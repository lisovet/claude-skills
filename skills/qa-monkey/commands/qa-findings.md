---
description: "Show current QA Monkey findings"
allowed-tools: ["Read"]
---

# QA Findings

Read and display `.claude/qa-findings.md` if it exists.

If it doesn't exist, say "No QA findings yet. Run /qa-monkey to start investigating."

Display the findings in a clear summary format:
- Count of Critical / Warning / Verified items
- List active findings with confidence scores
- Show confidence map (what's been verified)
