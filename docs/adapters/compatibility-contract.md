# 多工具兼容契约（Compatibility Contract）

目标：为 Claude Code / Codex / OpenCode / Trae / Qoder 固化**稳定、可版本化**的安装目录结构与组合规则；并保证用户可以从 `dist/` 直接 copy 后可用。

本契约只约束工具侧入口与 `dist/` 产物形态；规则真相源仍在 `global/`、`project/`、`skills/`。

## 通用术语

- Global Rules：`global/` 的通用治理与 Laravel baseline
- Project Rules：`project/rules.md`（项目级工作流约定）
- Skills：`skills/*/SKILL.md`（场景 / Profile）
- Router Skill：用于场景路由与参数补齐（Scene/Stage/TaskId），不替代专用场景 Skill
- Project Skill：将 Project Rules 以 skill 形态提供给支持 skills 的工具
- Project Assets：`dist/project-assets/**`（脚本/模板，可选安装）

## 通用组合与优先级

优先级（高 → 低）：

1. Hard（Global Reality Layer：范围控制/Stop Conditions/迁移安全/中文编码/验证闭环等）
2. Project Rules / Project Skill（可选；仓库绑定的工作流约定）
3. Profile（默认不启用；显式启用后生效）
4. Community Baseline（Laravel 技术底线与工程惯例）

Router 与 Scenarios：

- Router 只负责“选用哪个场景 Skill / 需要哪些显式参数”，不覆盖专用场景 Skill 的闭环步骤
- 若用户请求明确命中某个场景 Skill：场景 Skill 优先于 Router
- Profile 只有在用户明确启用或满足启用条件时才可建议启用

## 工具兼容契约

### Claude Code（单入口文件，不支持 skills）

- dist 入口：`dist/claude/CLAUDE.md`
- 安装位置：项目根目录 `CLAUDE.md`
- 能力假设：不依赖 include/import；不假设支持 skills
- 最小可用安装：仅复制 `CLAUDE.md`
- 推荐组合：`CLAUDE.md` +（按需手工追加）Profile 内容
- Router/Scenarios：不支持独立 Router/场景 skills 安装；以入口文件内的规则与用户提示进行“手工路由”
- Project Rules：已在入口文件中提供“可选启用”段落
- Project Assets：按需从 `dist/project-assets/**` 复制到项目约定目录

### Codex（单入口文件，可选全局入口；不假设 skills）

- dist 入口：`dist/codex/AGENTS.md`
- 安装位置：项目根目录 `AGENTS.md`（可选：工具支持时使用全局入口承载 Global）
- 能力假设：不依赖 include/import；不假设支持 skills
- 最小可用安装：仅复制项目级 `AGENTS.md`
- 推荐组合：
  - 项目级 `AGENTS.md`（全量可用）；或
  - 全局入口承载 Global + 项目级 `AGENTS.md` 承载项目特定内容（确保 Hard 不被覆盖）
- Router/Scenarios：不支持独立 Router/场景 skills 安装；以入口文件内的规则与用户提示进行“手工路由”
- Project Rules：已在入口文件中提供“可选启用”段落
- Project Assets：按需从 `dist/project-assets/**` 复制到项目约定目录

### OpenCode（单入口文件；不假设 skills）

- dist 入口：`dist/opencode/AGENTS.md`
- 安装位置：项目根目录 `AGENTS.md`
- 能力假设：不依赖 include/import；不假设支持 skills
- 最小可用安装：仅复制项目级 `AGENTS.md`
- 推荐组合：`AGENTS.md` +（按需手工追加）Profile 内容
- Router/Scenarios：不支持独立 Router/场景 skills 安装；以入口文件内的规则与用户提示进行“手工路由”
- Project Rules：已在入口文件中提供“可选启用”段落
- Project Assets：按需从 `dist/project-assets/**` 复制到项目约定目录

### Trae（skills 目录，目录 + SKILL.md）

- dist 入口：`dist/trae/skills/<skill>/SKILL.md`
- 安装位置：Trae skills 目录（以工具配置为准）
- 能力假设：支持“目录 + SKILL.md”形式的 skills；不要求特定安装器
- 最小可用安装：
  - 必选：`laravel-agent-global`
  - 可选：选择一个或多个 `laravel-agent-scenario-*`
- 推荐组合：
  - `laravel-agent-router` + `laravel-agent-global`
  - `laravel-agent-project`（需要项目工作流时）
  - `laravel-agent-scenario-*`（MVP 场景闭环）
  - `laravel-agent-profile-*`（显式启用时）
- Project Assets：按需从 `dist/project-assets/**` 复制到项目约定目录

### Qoder（项目内 .qoder 目录）

- dist 入口：`dist/qoder/.qoder/**`
- 安装位置：项目根目录 `.qoder/**`
- 能力假设：支持 `.qoder/agents/*.md` + `.qoder/skills/*.md`；不依赖 include/import
- 最小可用安装：
  - `.qoder/agents/laravel-agent.md`
  - `.qoder/skills/laravel-agent-global.md`
  - 可选：一个或多个 `.qoder/skills/laravel-agent-scenario-*.md`
- 推荐组合：
  - `laravel-agent.md` + `laravel-agent-router.md` + `laravel-agent-global.md`
  - `laravel-agent-project.md`（需要项目工作流时）
  - `laravel-agent-scenario-*.md`（MVP 场景闭环）
  - `laravel-agent-profile-*.md`（显式启用时）
- Project Assets：按需从 `dist/project-assets/**` 复制到项目约定目录

