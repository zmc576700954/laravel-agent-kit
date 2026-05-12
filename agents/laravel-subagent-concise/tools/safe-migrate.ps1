<#
.SYNOPSIS
安全执行最近新增的 Laravel 数据库迁移文件。

.DESCRIPTION
该脚本旨在提供给 AI Agent 或自动化流程使用。它会查找 `database/migrations` 目录下最新修改的 PHP 文件，并通过 `--path` 参数定向执行 `php artisan migrate`。这避免了执行危险的全局 `migrate` 或 `migrate:fresh` 命令，确保数据库的安全可控。

.EXAMPLE
.\safe-migrate.ps1
#>

$ErrorActionPreference = "Stop"

# 获取最新修改的 migration 文件
$latestMigration = Get-ChildItem -Path "database/migrations" -Filter "*.php" | Sort-Object LastWriteTime -Descending | Select-Object -First 1

if (-not $latestMigration) {
    Write-Host "未找到任何迁移文件。" -ForegroundColor Yellow
    exit 0
}

$migrationPath = "database/migrations/" + $latestMigration.Name

Write-Host ">>> 发现最新迁移文件: $migrationPath" -ForegroundColor Cyan
Write-Host ">>> 正在执行定向迁移..." -ForegroundColor Cyan

# 执行 Laravel 定向迁移
$command = "php artisan migrate --path=`"$migrationPath`""
Invoke-Expression $command

if ($LASTEXITCODE -eq 0) {
    Write-Host ">>> 迁移执行成功!" -ForegroundColor Green
} else {
    Write-Host ">>> 迁移执行失败! 请检查日志。" -ForegroundColor Red
}
exit $LASTEXITCODE
