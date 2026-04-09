#!/bin/bash
# Setup script for QA Fix — initializes the remediation pipeline

set -euo pipefail

STATE_FILE=".claude/qa-fix.local.md"
FINDINGS_FILE=".claude/qa-findings.md"
PRDS_DIR=".claude/qa-fix-prds"

# Parse arguments
CRITICAL_ONLY="false"
FINDING_ID=""
DRY_RUN="false"
PRD_FORMAT="auto"
BATCH_MODE="false"
AUTO_APPROVE="false"
MERGE_ON_SHIP="false"
MAX_LOOPS=3
TIMEOUT=15
PROMPT=""

while [[ $# -gt 0 ]]; do
  case $1 in
    --critical-only)
      CRITICAL_ONLY="true"
      shift
      ;;
    --finding)
      FINDING_ID="$2"
      shift 2
      ;;
    --dry-run)
      DRY_RUN="true"
      shift
      ;;
    --prd)
      PRD_FORMAT="$2"
      shift 2
      ;;
    --batch)
      BATCH_MODE="true"
      shift
      ;;
    --auto-approve-low-risk)
      AUTO_APPROVE="true"
      shift
      ;;
    --merge)
      MERGE_ON_SHIP="true"
      shift
      ;;
    --max-loops)
      MAX_LOOPS="$2"
      shift 2
      ;;
    --timeout)
      TIMEOUT="$2"
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

# Create directories
mkdir -p .claude
mkdir -p "$PRDS_DIR"

# Check for existing session
if [ -f "$STATE_FILE" ]; then
  EXISTING_PHASE=$(sed -n '/^---$/,/^---$/{ /^---$/d; p; }' "$STATE_FILE" | grep '^phase:' | sed 's/phase: *//')
  EXISTING_FIX=$(sed -n '/^---$/,/^---$/{ /^---$/d; p; }' "$STATE_FILE" | grep '^current_fix:' | sed 's/current_fix: *//')
  echo "Found interrupted remediation session."
  echo "  Phase: ${EXISTING_PHASE:-unknown}"
  echo "  Current fix: ${EXISTING_FIX:-unknown}"
  echo ""
  echo "The orchestrator will offer to resume or restart."
  exit 0
fi

# Validate findings file exists
if [ ! -f "$FINDINGS_FILE" ]; then
  echo "No findings file found at $FINDINGS_FILE"
  echo "Run /qa-monkey first to investigate your project."
  exit 1
fi

# Check for remediable findings
CRITICAL_COUNT=$(grep -c "^### CRITICAL" "$FINDINGS_FILE" 2>/dev/null || echo "0")
WARNING_COUNT=$(grep -c "^### WARNING" "$FINDINGS_FILE" 2>/dev/null || echo "0")

# Filter out already-resolved findings
RESOLVED_COUNT=$(grep -c "^Status: RESOLVED" "$FINDINGS_FILE" 2>/dev/null || echo "0")

if [[ "$CRITICAL_ONLY" == "true" ]]; then
  TOTAL=$CRITICAL_COUNT
else
  TOTAL=$((CRITICAL_COUNT + WARNING_COUNT))
fi

if [[ $TOTAL -eq 0 ]]; then
  echo "No remediable findings found."
  echo "  CRITICAL: $CRITICAL_COUNT"
  echo "  WARNING: $WARNING_COUNT"
  echo "  Already resolved: $RESOLVED_COUNT"
  echo ""
  echo "Run /qa-monkey to investigate your project first."
  exit 1
fi

# Determine branch strategy
if [[ "$BATCH_MODE" == "true" ]]; then
  BRANCH_STRATEGY="batch"
else
  BRANCH_STRATEGY="per_finding"
fi

# Generate session ID
SESSION_ID="fix-$$-$(date +%s)"

# Create state file
cat > "$STATE_FILE" << STATEEOF
---
active: true
phase: triage
current_fix: 0
total_fixes: 0
fixes_completed: []
fixes_remaining: []
batch_mode: $BATCH_MODE
prd_format: $PRD_FORMAT
auto_approve: $AUTO_APPROVE
merge_on_ship: $MERGE_ON_SHIP
branch_strategy: $BRANCH_STRATEGY
critical_only: $CRITICAL_ONLY
finding_id: $FINDING_ID
dry_run: $DRY_RUN
max_loops: $MAX_LOOPS
timeout_minutes: $TIMEOUT
session_id: $SESSION_ID
started_at: "$(date -u '+%Y-%m-%dT%H:%M:%SZ')"
---

${PROMPT:-Fix all remediable findings from qa-findings.md.}
STATEEOF

echo "QA Fix initialized!"
echo ""
echo "  Findings: $CRITICAL_COUNT critical, $WARNING_COUNT warning"
echo "  Mode: $([ "$BATCH_MODE" = "true" ] && echo "batch (one PR)" || echo "per-finding (separate PRs)")"
echo "  PRD format: $PRD_FORMAT"
echo "  Dry run: $DRY_RUN"
echo "  Max loops: $MAX_LOOPS"
echo "  Timeout: ${TIMEOUT}min per fix"
[ -n "$FINDING_ID" ] && echo "  Target: $FINDING_ID"
echo ""
echo "  PRDs will be saved to $PRDS_DIR/"
echo "  To cancel: delete $STATE_FILE"
