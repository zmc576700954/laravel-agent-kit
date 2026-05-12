<#
.SYNOPSIS
生成 Laravel API 组件（FormRequest 与 JsonResource）的标准脚本。

.DESCRIPTION
此工具供 Agent 在需要分离控制器逻辑时使用。它接受资源名称作为参数，一次性生成对应的 `FormRequest`（用于校验/鉴权）和 `Resource`（用于 API 契约化输出）。

.PARAMETER Name
组件的基础名称，例如 'User'，脚本会自动生成 `StoreUserRequest`, `UpdateUserRequest`, 和 `UserResource`。

.EXAMPLE
.\make-api-component.ps1 -Name "Order"
#>

param (
    [Parameter(Mandatory=$true)]
    [string]$Name
)

$ErrorActionPreference = "Stop"

Write-Host ">>> 正在生成 $Name 的 API 组件..." -ForegroundColor Cyan

# 1. 生成 StoreRequest
$storeReq = "Store${Name}Request"
Write-Host "> php artisan make:request $storeReq"
php artisan make:request $storeReq

# 2. 生成 UpdateRequest
$updateReq = "Update${Name}Request"
Write-Host "> php artisan make:request $updateReq"
php artisan make:request $updateReq

# 3. 生成 API Resource
$resource = "${Name}Resource"
Write-Host "> php artisan make:resource $resource"
php artisan make:resource $resource

Write-Host ">>> API 组件生成完毕！请继续将它们应用到你的 Controller 中。" -ForegroundColor Green
exit 0
