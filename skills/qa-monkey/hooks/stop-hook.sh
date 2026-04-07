#!/bin/bash

# QA Monkey Stop Hook
# Prevents session exit when a QA investigation loop is active
# Feeds the investigation prompt back to continue the next iteration

set -euo pipefail

# Read hook input from stdin (advanced stop hook API)
HOOK_INPUT=$(cat)

# Check if QA Monkey is active
STATE_FILE=".claude/qa-monkey.local.md"

if [[ ! -f "$STATE_FILE" ]]; then
  exit 0  # No active loop — allow exit
fi

# Parse markdown frontmatter (YAML between ---) and extract values
FRONTMATTER=$(sed -n '/^---$/,/^---$/{ /^---$/d; p; }' "$STATE_FILE")
ITERATION=$(echo "$FRONTMATTER" | grep '^iteration:' | sed 's/iteration: *//')
MAX_ITERATIONS=$(echo "$FRONTMATTER" | grep '^max_iterations:' | sed 's/max_iterations: *//')
COMPLETION_PROMISE=$(echo "$FRONTMATTER" | grep '^completion_promise:' | sed 's/completion_promise: *//' | sed 's/^"\(.*\)"$/\1/')
STALE_COUNT=$(echo "$FRONTMATTER" | grep '^stale_count:' | sed 's/stale_count: *//' || echo "0")

# Session isolation: don't interfere with other sessions
STATE_SESSION=$(echo "$FRONTMATTER" | grep '^session_id:' | sed 's/session_id: *//' || true)
HOOK_SESSION=$(echo "$HOOK_INPUT" | jq -r '.session_id // ""')
if [[ -n "$STATE_SESSION" ]] && [[ "$STATE_SESSION" != "$HOOK_SESSION" ]]; then
  exit 0
fi

# Validate numeric fields
if [[ ! "$ITERATION" =~ ^[0-9]+$ ]]; then
  echo "Warning: QA Monkey state corrupted (iteration='$ITERATION'). Stopping." >&2
  rm "$STATE_FILE"
  exit 0
fi

if [[ ! "$MAX_ITERATIONS" =~ ^[0-9]+$ ]]; then
  echo "Warning: QA Monkey state corrupted (max_iterations='$MAX_ITERATIONS'). Stopping." >&2
  rm "$STATE_FILE"
  exit 0
fi

if [[ ! "$STALE_COUNT" =~ ^[0-9]+$ ]]; then
  STALE_COUNT=0
fi

# Check max iterations
if [[ $MAX_ITERATIONS -gt 0 ]] && [[ $ITERATION -ge $MAX_ITERATIONS ]]; then
  echo "QA Monkey: max iterations ($MAX_ITERATIONS) reached."
  rm "$STATE_FILE"
  exit 0
fi

# Check stale (3 consecutive iterations with no new findings)
if [[ $STALE_COUNT -ge 3 ]]; then
  echo "QA Monkey: 3 consecutive clean iterations. System verified."
  rm "$STATE_FILE"
  exit 0
fi

# Get transcript path from hook input for promise detection
TRANSCRIPT_PATH=$(echo "$HOOK_INPUT" | jq -r '.transcript_path')

# Check for completion promise (only if set and transcript available)
if [[ "$COMPLETION_PROMISE" != "null" ]] && [[ "$COMPLETION_PROMISE" != "none" ]] && [[ -n "$COMPLETION_PROMISE" ]]; then
  if [[ -f "$TRANSCRIPT_PATH" ]]; then
    LAST_LINES=$(grep '"role":"assistant"' "$TRANSCRIPT_PATH" 2>/dev/null | tail -n 100 || true)
    if [[ -n "$LAST_LINES" ]]; then
      set +e
      LAST_OUTPUT=$(echo "$LAST_LINES" | jq -rs '
        map(.message.content[]? | select(.type == "text") | .text) | last // ""
      ' 2>/dev/null)
      set -e

      # Extract promise text using perl (handles multiline, special chars)
      PROMISE_TEXT=$(echo "$LAST_OUTPUT" | perl -0777 -pe 's/.*?<promise>(.*?)<\/promise>.*/$1/s; s/^\s+|\s+$//g; s/\s+/ /g' 2>/dev/null || echo "")

      # Literal string comparison (not pattern matching)
      if [[ -n "$PROMISE_TEXT" ]] && [[ "$PROMISE_TEXT" = "$COMPLETION_PROMISE" ]]; then
        echo "QA Monkey: completion promise detected."
        rm "$STATE_FILE"
        exit 0
      fi
    fi
  fi
fi

# Check stale findings — did this iteration produce new findings?
FINDINGS_FILE=".claude/qa-findings.md"
if [[ -f "$FINDINGS_FILE" ]] && [[ -f "$TRANSCRIPT_PATH" ]]; then
  # Check if the last assistant output mentions any new findings
  set +e
  LAST_OUTPUT=${LAST_OUTPUT:-$(grep '"role":"assistant"' "$TRANSCRIPT_PATH" 2>/dev/null | tail -n 50 | jq -rs 'map(.message.content[]? | select(.type == "text") | .text) | last // ""' 2>/dev/null)}
  set -e

  if echo "$LAST_OUTPUT" | grep -qi "confidence:"; then
    NEW_STALE=0
  else
    NEW_STALE=$((STALE_COUNT + 1))
  fi
else
  NEW_STALE=$((STALE_COUNT + 1))
fi

# Continue loop — increment iteration, update stale count
NEXT_ITERATION=$((ITERATION + 1))

# Extract prompt (everything after the closing ---)
PROMPT_TEXT=$(awk '/^---$/{i++; next} i>=2' "$STATE_FILE")

if [[ -z "$PROMPT_TEXT" ]]; then
  echo "Warning: QA Monkey state file has no prompt. Stopping." >&2
  rm "$STATE_FILE"
  exit 0
fi

# Atomic update: write to temp, then move
TEMP_FILE="${STATE_FILE}.tmp.$$"
sed "s/^iteration: .*/iteration: $NEXT_ITERATION/" "$STATE_FILE" | \
  sed "s/^stale_count: .*/stale_count: $NEW_STALE/" > "$TEMP_FILE"
mv "$TEMP_FILE" "$STATE_FILE"

# Build system message
SYSTEM_MSG="QA Monkey iteration $NEXT_ITERATION (stale: $NEW_STALE/3)"
if [[ "$COMPLETION_PROMISE" != "null" ]] && [[ "$COMPLETION_PROMISE" != "none" ]] && [[ -n "$COMPLETION_PROMISE" ]]; then
  SYSTEM_MSG="$SYSTEM_MSG | Promise: output <promise>$COMPLETION_PROMISE</promise> when TRUE"
fi

# Output JSON to block exit and feed prompt back
jq -n \
  --arg prompt "$PROMPT_TEXT" \
  --arg msg "$SYSTEM_MSG" \
  '{
    "decision": "block",
    "reason": $prompt,
    "systemMessage": $msg
  }'

exit 0
