# STATUS: OPEN
# TITLE: Bootstrap CI and dev ergonomics

Goal:
- Ensure CI passes even if ./api or ./front do not exist.

Required:
- Add .github/workflows/ci.yml with conditional jobs for backend, frontend, docker build.
- Add scripts/dev_check.(ps1|sh) that run ruff/mypy/pytest for ./api if present, npm build for ./front if present, docker build if Dockerfile exists.
- Add README section if a README exists; otherwise skip.

Acceptance:
- ci.yml succeeds on PR in a skeleton repo.
- scripts/dev_check return code 0 with missing components.
