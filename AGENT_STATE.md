CURRENT_STEP: DEV_CYCLE
DATE: 2025-08-18 01:37:39 +0400

WHAT_CHANGED:
- Added PS1/dev_cycle.ps1 to automate pull, docker cycle, tests, frontend build, and API smoke checks.

TESTS_RUN:
- pytest

NEXT_STEP: NONE

AGENT_RULES_DELTA:
- Ensure AGENT_STATE.md uses required section headers from the start.
- Keep scripts generic to handle missing directories gracefully.
