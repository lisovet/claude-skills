# QA Monkey — Known Issues (Accepted Risks)

Add findings here that you've reviewed and accepted. QA Monkey
will not re-report these in future runs.

Format:
```
## {finding summary}
Accepted: {date}
Reason: {why this is acceptable}
```

## Example: Pre-existing test failures
Accepted: 2026-04-06
Reason: SQLAlchemy model tests fail on Python 3.9 but work on 3.10 (Railway uses 3.10)
