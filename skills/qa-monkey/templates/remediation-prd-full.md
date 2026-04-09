---
finding_ids: []
status: pending
loop_count: 0
branch: ""
source_agent: ""
risk: medium
---

# Remediation: {FINDING_ID} -- {summary}

## Finding
{finding_description}
Confidence: {confidence}% | Source: qa-monkey iteration {iteration}, {agent_name}

## User Journey
1. {step_1_what_user_does}
2. {step_2_what_user_sees}

### Current Experience (broken)
- {broken_behavior_description}

### Fixed Experience
- {fixed_behavior_description}

## Screen States
| State | What user sees |
|-------|---------------|
| Loading | {loading_state} |
| Loaded | {loaded_state} |
| Error | {error_state} |
| Empty | {empty_state} |

## Root Cause
- {root_cause_analysis}

## Fix
1. {fix_step_1}
2. {fix_step_2}

### Alternatives Rejected
- {alternative}: {reason_rejected}

## Files
- {file_path} -- {what_changes}

## Acceptance Criteria
- GIVEN {precondition} WHEN {action} THEN {expected_result}

## Risk: {LOW|MEDIUM|HIGH}
- {risk_description}
- Regression: {regression_risk}
- UX risk: {ux_risk}
