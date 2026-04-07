---
description: "Cancel an active QA Monkey loop"
allowed-tools: ["Bash", "Read"]
---

# Cancel QA Monkey

1. Check if `.claude/qa-monkey.local.md` exists using Bash: `test -f .claude/qa-monkey.local.md && echo "EXISTS" || echo "NOT_FOUND"`

2. **If NOT_FOUND**: Say "No active QA Monkey loop found."

3. **If EXISTS**:
   - Read `.claude/qa-monkey.local.md` to get the current iteration
   - Remove the file using Bash: `rm .claude/qa-monkey.local.md`
   - Report: "QA Monkey cancelled (was at iteration N). Findings preserved in .claude/qa-findings.md"
