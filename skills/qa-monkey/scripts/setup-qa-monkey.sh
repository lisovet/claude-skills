#!/bin/bash
# Setup script for QA Monkey — initializes the investigation loop

set -euo pipefail

STATE_FILE=".claude/qa-monkey.local.md"

# Parse arguments
MAX_ITER=0
PROMISE="none"
FIX_MODE="false"
VISUAL_MODE="false"
CI_MODE="false"
CONFIDENCE=80
FOCUS=""
PROMPT=""

while [[ $# -gt 0 ]]; do
  case $1 in
    --max-iterations)
      MAX_ITER="$2"
      shift 2
      ;;
    --completion-promise)
      PROMISE="$2"
      shift 2
      ;;
    --fix)
      FIX_MODE="true"
      shift
      ;;
    --visual)
      VISUAL_MODE="true"
      shift
      ;;
    --ci)
      CI_MODE="true"
      shift
      ;;
    --confidence)
      CONFIDENCE="$2"
      shift 2
      ;;
    --focus)
      FOCUS="$2"
      shift 2
      ;;
    *)
      if [ -z "$PROMPT" ]; then
        PROMPT="$1"
      else
        PROMPT="$PROMPT $1"
      fi
      shift
      ;;
  esac
done

# Handle --ci flag: force 1 iteration unless explicitly overridden
if [[ "$CI_MODE" == "true" ]] && [[ "$MAX_ITER" -eq 0 ]]; then
  MAX_ITER=1
fi

# Default prompt
if [ -z "$PROMPT" ]; then
  PROMPT="Investigate this project for bugs, silent failures, and inconsistencies. Be suspicious. Verify everything."
fi

# Create state directory
mkdir -p .claude

# Check if already running
if [ -f "$STATE_FILE" ]; then
  EXISTING_ITER=$(sed -n '/^---$/,/^---$/{ /^---$/d; p; }' "$STATE_FILE" | grep '^iteration:' | sed 's/iteration: *//')
  echo "QA Monkey already active (iteration ${EXISTING_ITER:-?})."
  echo "Use /cancel-qa to stop, or let it continue."
  exit 0
fi

# Generate session ID for isolation
SESSION_ID="qa-$$-$(date +%s)"

# Create state file
cat > "$STATE_FILE" << STATEEOF
---
active: true
iteration: 1
max_iterations: $MAX_ITER
completion_promise: $PROMISE
fix_mode: $FIX_MODE
visual_mode: $VISUAL_MODE
ci_mode: $CI_MODE
confidence_threshold: $CONFIDENCE
focus: $FOCUS
stale_count: 0
session_id: $SESSION_ID
started_at: "$(date -u '+%Y-%m-%dT%H:%M:%SZ')"
---

$PROMPT
STATEEOF

# Initialize findings file if it doesn't exist
if [ ! -f ".claude/qa-findings.md" ]; then
  PROJECT_NAME=$(basename "$(pwd)")
  cat > ".claude/qa-findings.md" << FINDEOF
# QA Monkey Findings

Project: $PROJECT_NAME
Started: $(date -u '+%Y-%m-%d %H:%M UTC')
Iterations: 0

## Heuristics Status
- [ ] H1: Endpoint Probe
- [ ] H2: Test Suite
- [ ] H3: Config Drift
- [ ] H4: File Integrity
- [ ] H5: Count Comparison
- [ ] H6: Staleness Check
- [ ] H7: Dead Code (ruff + vulture for Python)
- [ ] H8: Parallel System Detection
- [ ] H9: Silent Failure Scan
- [ ] H10: Log Analysis
- [ ] H11: Visual - Screenshot Capture
- [ ] H12: Visual - API vs Display
- [ ] H13: Visual - Interactive Probe
- [ ] H14: Visual - Error States

## Active Findings
_(findings will appear here)_

## Resolved Findings
_(fixed items moved here)_

## Rejected Hypotheses
_(tested but disproven theories)_
FINDEOF
fi

echo "QA Monkey activated!"
echo ""
echo "Iteration: 1"
echo "Max iterations: $([ "$MAX_ITER" -gt 0 ] && echo "$MAX_ITER" || echo "unlimited")"
echo "Completion promise: $PROMISE"
echo "Fix mode: $FIX_MODE"
echo "Visual mode: $VISUAL_MODE"
echo "CI mode: $CI_MODE"
echo "Confidence threshold: $CONFIDENCE"
[ -n "$FOCUS" ] && echo "Focus: $FOCUS"
echo ""
echo "The stop hook is now active. QA Monkey will investigate"
echo "your project iteratively until issues are resolved."
echo ""
echo "To monitor: cat .claude/qa-findings.md"
echo "To stop: /cancel-qa"
