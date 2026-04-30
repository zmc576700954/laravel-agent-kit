[CmdletBinding()]
param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$Args
)

$repoCtl = Join-Path (Get-Location).Path '.codex/bin/migrationctl-lite.ps1'
if (-not (Test-Path -LiteralPath $repoCtl)) {
    throw "Repo-local migration controller not found: $repoCtl"
}

& powershell -NoProfile -ExecutionPolicy Bypass -File $repoCtl @Args
