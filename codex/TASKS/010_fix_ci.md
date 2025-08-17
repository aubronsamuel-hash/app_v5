# STATUS: OPEN
# TITLE: Harden CI caching and pin versions

Goal:
- Make CI faster and deterministic.

Required:
- Add caches for pip and npm where applicable.
- Pin Python to 3.11 and Node to 20.x.
- Ensure jobs skip gracefully when folders or lockfiles are absent.

Acceptance:
- CI stays green and shows cache usage on re-runs.
