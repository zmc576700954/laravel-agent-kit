# Adapter：Trae

## 入口识别

- Trae 支持以“Skill 目录”形式安装规则，每个 Skill 目录包含一个 `SKILL.md` 作为入口。

## 安装路径

- 以 Trae 的 skill 搜索路径为准（常见做法是将 skill 目录复制到工具配置指定的位置）。
- 本 Kit 在 `dist/trae/skills/` 提供可安装的 skill 目录。

## 最小可用安装

- 必选：`dist/trae/skills/laravel-agent-global/`
- 可选：按需安装一个或多个 `dist/trae/skills/laravel-agent-scenario-*/`

## 推荐安装组合

- `laravel-agent-router` + `laravel-agent-global`
- （可选）`laravel-agent-project`（需要项目工作流时）
- 场景 skills：`laravel-agent-scenario-*`
- Profile skills：`laravel-agent-profile-*`（显式启用时）

## Router / Project / Profiles / Scenarios（组合规则）

- `laravel-agent-global`：Global 规则（Baseline + Reality Layer + Prompt 输出契约 + Checklist）
- `laravel-agent-router`：默认入口与兜底路由（专用场景 Skill 优先；显式 Scene/Stage/TaskId）
- `laravel-agent-project`：项目级操作性规则（Task Record、repo-local controller 约定）
- `laravel-agent-profile-filament-admin-migration`：示例 Profile（Filament Admin 迁移）

## Project Assets（可选）

- 通用资产包位置：`dist/project-assets/**`
- 用途：脚本/模板等附属资产；不影响最小安装可用性

## 限制与兼容性

- 不强依赖任何 skill 安装器；只要安装器遵循“目录 + SKILL.md”约定即可兼容（例如 skill4agent 类工具）。

## 升级/回滚注意点

- 升级时优先对比你已安装的 skill 目录与 `dist/trae/skills/` 的差异，避免覆盖本地自定义。
