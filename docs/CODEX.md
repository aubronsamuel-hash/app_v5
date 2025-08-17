# Codex automation quick start

- Local run (PowerShell):
  .\codex\run_agent.ps1
- Local run (bash):
  bash ./codex/run_agent.sh

Prereqs:
- Codex CLI installed (npm i -g @openai/codex)
- OPENAI_API_KEY exported in environment
- gh CLI optional for PR creation

Flow:
1) Add a task file under codex/TASKS with first line "# STATUS: OPEN".
2) Run the agent. It will produce a unified diff, create a branch and open a PR.
3) CI checks run. Merge if green.
