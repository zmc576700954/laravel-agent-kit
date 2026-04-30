# 安装指南（copy / symlink）

本 Kit 的 `dist/` 目录提供“复制粘贴即可用”的产物；推荐按目标工具选择对应入口文件/目录安装到你的项目中。

相关文档：

- 多工具兼容契约：`docs/adapters/compatibility-contract.md`
- Verification Matrix：`docs/adapters/verification-matrix.md`

## 最小/推荐安装组合（按工具）

| 工具 | 最小可用安装 | 推荐安装组合 |
| --- | --- | --- |
| Claude Code | `dist/claude/CLAUDE.md` → `CLAUDE.md` | `CLAUDE.md` +（按需手工追加）Profile；Project Rules 段落按需启用 |
| Codex | `dist/codex/AGENTS.md` → `AGENTS.md` | 项目级 `AGENTS.md`（全量可用）；或全局入口承载 Global + 项目 `AGENTS.md` 承载项目特定内容 |
| OpenCode | `dist/opencode/AGENTS.md` → `AGENTS.md` | `AGENTS.md` +（按需手工追加）Profile；Project Rules 段落按需启用 |
| Trae | `dist/trae/skills/laravel-agent-global/` | `laravel-agent-router` + `laravel-agent-global` +（可选）`laravel-agent-project` + 场景 skills |
| Qoder | `dist/qoder/.qoder/` | `laravel-agent.md` + `laravel-agent-router.md` + `laravel-agent-global.md` +（可选）`laravel-agent-project.md` + 场景 skills |

## 方式 1：copy（推荐给大多数团队）

特点：项目自包含；升级时需要手工对比并替换；适合 CI/多人协作。

通用流程：

1. `git clone` 本仓库（或以子模块/下载包方式获取）。
2. 从 `dist/<tool>/` 复制入口文件/目录到你的项目。
3. （可选）按需安装 Skills（场景 / Profile），并在 Prompt 中显式启用 Profile 类 Skill。

示例（项目根目录）：

- Claude Code：复制 `dist/claude/CLAUDE.md` → `CLAUDE.md`
- Codex：复制 `dist/codex/AGENTS.md` → `AGENTS.md`
- OpenCode：复制 `dist/opencode/AGENTS.md` → `AGENTS.md`
- Trae：复制 `dist/trae/skills/*` → 安装到 Trae 的 skills 目录
- Qoder：复制 `dist/qoder/.qoder/` → 项目根目录 `.qoder/`

## Skills 安装（Trae / Qoder）

### Router / Project（推荐组合）

推荐至少安装：

- Router（默认入口）：`laravel-agent-router`
- Global（基础必选）：`laravel-agent-global`
- Project（可选）：`laravel-agent-project`（Project Rules：Task Record、repo-local controller 约定等）

### 场景 Skills（MVP）

这些 Skill 面向高频开发闭环：新增/修改、排查/修复、迁移安全、性能、测试。Source of Truth 在 `skills/`，但推荐直接复制 dist 产物安装：

- Trae：复制 `dist/trae/skills/laravel-agent-scenario-*/`
- Qoder：复制 `dist/qoder/.qoder/skills/laravel-agent-scenario-*.md`

### Profile Skills（默认不启用）

Profile 用于特定栈/特定协作协议增强（如 Filament/OwlAdmin），默认不启用：

- Trae：安装对应 `dist/trae/skills/laravel-agent-profile-*/`
- Qoder：安装对应 `dist/qoder/.qoder/skills/laravel-agent-profile-*.md`
- 启用方式：在 Prompt 中明确声明“本次启用 Profile：xxx”，且仅在满足启用条件时使用

## 方式 2：symlink（推荐给维护者/单人或小团队）

特点：升级只需更新 Kit 仓库即可同步到项目；但对路径与跨平台更敏感。

通用流程：

1. 将本仓库放在稳定位置（例如 `~/dev/laravel-agent-kit`）。
2. 在项目内创建符号链接指向 `dist/` 产物。
3. 升级时在 Kit 仓库 `git pull`，项目自动生效；回滚则切回旧 tag/commit。

示例（仅示意，命令以你的系统为准）：

- `ln -s ~/dev/laravel-agent-kit/dist/claude/CLAUDE.md ./CLAUDE.md`
- `ln -s ~/dev/laravel-agent-kit/dist/codex/AGENTS.md ./AGENTS.md`
- `ln -s ~/dev/laravel-agent-kit/dist/qoder/.qoder ./.qoder`

## Profile 启用方式（通用约定）

- Profile 默认不启用。
- 启用方式建议二选一：
  1. 在入口文件中追加 Profile 内容，并在 Prompt 中声明“本次启用 Profile：xxx”；
  2. 在工具支持 skills 的情况下，将 Profile 作为独立 skill 安装，并显式加载。

## Project Assets（可选）

若你需要脚本/模板类附属资产（例如 wrapper 脚本、任务记录模板），从本仓库复制：

- `dist/project-assets/*`
