# Adapter：Qoder

## 入口识别

- Qoder 使用项目内的 `.qoder/agents/*.md` 与 `.qoder/skills/*`。
- `agents` 通常用于定义“如何工作/输出格式”；`skills` 用于可复用的规则包。

## 安装路径

- 项目级：项目根目录 `.qoder/agents/` 与 `.qoder/skills/`

## 最小可用安装

- 复制 `dist/qoder/.qoder/` → 项目根目录 `.qoder/`
- 至少保证：
  - `.qoder/agents/laravel-agent.md`
  - `.qoder/skills/laravel-agent-global.md`
  - （可选）一个或多个 `.qoder/skills/laravel-agent-scenario-*.md`

## 推荐安装组合

- `.qoder/agents/laravel-agent.md` + `.qoder/skills/laravel-agent-router.md` + `.qoder/skills/laravel-agent-global.md`
- （可选）`.qoder/skills/laravel-agent-project.md`（需要项目工作流时）
- 场景 skills：`.qoder/skills/laravel-agent-scenario-*.md`
- Profile skills：`.qoder/skills/laravel-agent-profile-*.md`（显式启用时）

## Router / Project / Profiles / Scenarios（组合规则）

- 本 Kit 在 `dist/qoder/.qoder/` 提供可直接复制粘贴的目录结构：
  - `.qoder/agents/laravel-agent.md`
  - `.qoder/skills/laravel-agent-global.md`
  - `.qoder/skills/laravel-agent-router.md`
  - `.qoder/skills/laravel-agent-project.md`
  - `.qoder/skills/laravel-agent-profile-filament-admin-migration.md`

## Project Assets（可选）

- 通用资产包位置：`dist/project-assets/**`
- 用途：脚本/模板等附属资产；不影响最小安装可用性

## 限制与兼容性

- Qoder agent 文件通常需要 frontmatter；dist 产物提供最小 frontmatter 样例，避免依赖 include/import。

## 升级/回滚注意点

- 升级时优先对比项目内 `.qoder/` 与 Kit 的 `dist/qoder/.qoder/`，避免覆盖本地自定义 skills。
