# dev_cycle.ps1 - automate dev loop
Write-Host '=== Git update ==='
$pull = git pull 2>&1
Write-Host $pull
if ((git ls-files -u).Length -gt 0) {
  Write-Warning 'Merge conflicts detected. Resolve before continuing.'
  exit 1
}
git --no-pager log -5 --oneline

Write-Host '=== Docker compose refresh ==='
docker compose down
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
docker compose build --no-cache
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }
docker compose up -d
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Host '=== Backend tests ==='
pushd api >/dev/null
pytest
$backendTests = $LASTEXITCODE
popd >/dev/null

Write-Host '=== Frontend build ==='
pushd frontend >/dev/null
npm run typecheck
$tsCheck = $LASTEXITCODE
npm run build
$frontBuild = $LASTEXITCODE
popd >/dev/null

Write-Host '=== API smoke tests ==='
$baseUrl = 'http://localhost:8001'
Invoke-RestMethod "$baseUrl/healthz" -Method Get | Out-Null
$register = @{username='smoke';password='Smoke123!'} | ConvertTo-Json
Invoke-RestMethod "$baseUrl/auth/register" -Method Post -ContentType 'application/json' -Body $register | Out-Null
$token = Invoke-RestMethod "$baseUrl/auth/token-json" -Method Post -ContentType 'application/json' -Body (@{username='smoke';password='Smoke123!'} | ConvertTo-Json)
$headers = @{Authorization = "Bearer $($token.access_token)"}
Invoke-RestMethod "$baseUrl/auth/me" -Headers $headers | Out-Null

Write-Host '=== Summary ==='
Write-Host "Backend tests exit code: $backendTests"
Write-Host "Typecheck exit code: $tsCheck"
Write-Host "Frontend build exit code: $frontBuild"
