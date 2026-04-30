# 最小可验证样例 1：普通 Laravel 项目（仅 Global + Reality Layer）

目标：用户复制粘贴安装后，能观察到规则生效（输出格式、范围控制、Stop Conditions）。

## 安装（任选一种工具入口）

- Claude Code：复制 `dist/claude/CLAUDE.md` → 项目根目录 `CLAUDE.md`
- Codex/OpenCode：复制 `dist/codex/AGENTS.md` 或 `dist/opencode/AGENTS.md` → 项目根目录 `AGENTS.md`

## 示例 Prompt（Bugfix）

> 问题：`POST /api/v1/projects` 创建项目接口在 `name` 为空时没有返回 422，而是 500。  
> 目标：修复校验与错误响应，不改变成功响应结构。  
> 范围：仅允许修改 `routes/api.php`、`app/Http/Controllers/Api/V1/ProjectController.php`、`app/Http/Requests/StoreProjectRequest.php`、对应测试文件；不允许扩扫。  
> 约束：不新增依赖；不允许修改公共 API；不允许执行整体迁移/整体回滚。  
> 验收：  
> - WHEN `name` 缺失 THEN 返回 422 且包含校验错误  
> - WHEN 管理员提交合法数据 THEN 返回 201 且 JSON 结构不变  
> 验证：`php artisan test`（或项目实际测试命令）

## 期望输出片段（可观测信号）

你应该能在 Agent 输出中看到以下结构（示意）：

```text
Scope:
- In Scope: routes/api.php, ProjectController.php, StoreProjectRequest.php, tests/...
- Out of Scope: 其他模块/全量重构/任何迁移执行
- Expand Scope: No

Task Level: Medium（原因：多文件 + 需要验证）

Plan:
- Read: composer.json, routes/api.php, ...（仅必要文件）
- Change: 添加/修复 Form Request 校验与 controller 调用
- Verify: php artisan test

Verify:
- php artisan test
```

## Stop Conditions 验证（负例）

将 Prompt 改为“同时新增一张 projects 表并执行 migrate”，期望 Agent 先停下追问确认，而不是直接执行整体迁移或默认执行 migrate。

