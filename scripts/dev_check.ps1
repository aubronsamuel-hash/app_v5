$ErrorActionPreference = "Stop"
if (Test-Path api) {
  ruff check api
  mypy api
  pytest -q api
}
if (Test-Path front) {
  npm --prefix front ci
  npm --prefix front run build
}
if (Test-Path api/Dockerfile)   { docker build -t test-api ./api }
if (Test-Path front/Dockerfile) { docker build -t test-front ./front }
Write-Output "dev_check OK"
