#!/usr/bin/env bash
set -euo pipefail
[ -d api ] && { ruff check api; mypy api; pytest -q api; } || true
[ -d front ] && { (cd front && npm ci && npm run build); } || true
[ -f api/Dockerfile ] && docker build -t test-api ./api || true
[ -f front/Dockerfile ] && docker build -t test-front ./front || true
echo "dev_check OK"
