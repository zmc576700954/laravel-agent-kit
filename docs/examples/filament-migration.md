# 最小可验证样例 2：Filament 迁移任务（Global + Profile）

目标：验证 Profile 默认不启用；显式启用后生效，并且不违反 Reality Layer 的 Hard 约束。

## 安装

### 入口（任选一种）

- Claude Code：复制 `dist/claude/CLAUDE.md` → `CLAUDE.md`
- Codex/OpenCode：复制 `dist/codex/AGENTS.md` 或 `dist/opencode/AGENTS.md` → `AGENTS.md`
- Trae：安装 `dist/trae/skills/laravel-agent-global/` 与 `dist/trae/skills/laravel-agent-profile-filament-admin-migration/`
- Qoder：复制 `dist/qoder/.qoder/` → 项目根目录 `.qoder/`

### 启用 Profile

在 Prompt 中明确声明：

> 本次启用 Profile：Filament Admin 迁移（Filament Actions 约束等）

如果你的工具支持显式加载 skill/profile（Trae/Qoder），同时加载对应的 Profile skill。

## 示例 Prompt（Feature）

> 目标：把旧后台的“项目列表页”迁移为 Filament Resource（只改 Admin，不动 API）。  
> 范围：仅允许修改 `app/Filament/**` 与与其直接相关的 Service；不允许扩扫。  
> 约束：不新增依赖；不改数据库结构；不改接口契约；不执行整体迁移/整体回滚。  
> Profile：启用 Filament Admin 迁移 Profile。  
> 验收：  
> - WHEN 打开 Filament 项目列表页 THEN 列表可正常显示并支持基本操作  
> - WHEN 访问旧后台路径 THEN 行为保持不变（不强制删除旧代码）  
> 验证：最小验证 `php -l <changed-files>`，并补充项目实际测试命令（若存在）

## 期望输出片段（Profile 生效信号）

你应该能在 Agent 输出中看到类似内容（示意）：

```text
Scope:
- In Scope: app/Filament/**, app/Services/**（与本页相关）
- Out of Scope: API 相关目录、数据库迁移、权限真相源调整

Task Level: Heavy（原因：后台迁移 + 用户可见行为）

Plan:
- Ensure: Filament 相关改动只在 app/Filament/**
- Constraint: 不使用 Filament\Tables\Actions\*，统一用 Filament\Actions\*
- Verify: php -l <files>; php artisan route:list --path=...
```

## Profile 默认不启用验证

将 Prompt 中的 “Profile：启用 …” 删除，期望 Agent 不再强制应用 Filament Actions 约束，也不应自行推断并启用 Profile。

