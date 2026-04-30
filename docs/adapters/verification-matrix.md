# Verification Matrix（人工可核对）

目标：每次更新后，只需对照本页即可验证 `dist/` 产物与各工具端入口是否仍满足兼容契约。

## 1) dist 文件/目录清单（必须存在）

| 工具 | dist 侧必须存在 | 目的 |
| --- | --- | --- |
| Claude Code | `dist/claude/CLAUDE.md` | 项目级单文件入口 |
| Codex | `dist/codex/AGENTS.md` | 项目级单文件入口 |
| OpenCode | `dist/opencode/AGENTS.md` | 项目级单文件入口 |
| Trae | `dist/trae/skills/laravel-agent-global/SKILL.md` | Global skill |
| Trae | `dist/trae/skills/laravel-agent-router/SKILL.md` | Router skill（推荐） |
| Trae | `dist/trae/skills/laravel-agent-project/SKILL.md` | Project skill（可选） |
| Trae | `dist/trae/skills/laravel-agent-scenario-*/SKILL.md` | 场景 skills（按需） |
| Trae | `dist/trae/skills/laravel-agent-profile-*/SKILL.md` | Profile skills（按需） |
| Qoder | `dist/qoder/.qoder/agents/laravel-agent.md` | 项目内 agent 入口 |
| Qoder | `dist/qoder/.qoder/skills/laravel-agent-global.md` | Global skill |
| Qoder | `dist/qoder/.qoder/skills/laravel-agent-router.md` | Router skill（推荐） |
| Qoder | `dist/qoder/.qoder/skills/laravel-agent-project.md` | Project skill（可选） |
| Qoder | `dist/qoder/.qoder/skills/laravel-agent-scenario-*.md` | 场景 skills（按需） |
| Qoder | `dist/qoder/.qoder/skills/laravel-agent-profile-*.md` | Profile skills（按需） |
| 通用 | `dist/project-assets/**` | 可选资产包（脚本/模板） |

## 2) 入口文件/入口 Skill 的最小内容要求

本节用于验证“入口内容契约”没有因为拼装/生成漂移。

### Claude Code / Codex / OpenCode（单文件入口）

入口文件必须明确包含或声明：

- 输出契约：Scope / Task Level / Plan / Implement / Verify
- Stop Conditions：至少覆盖迁移/鉴权/接口契约/中文编码/依赖等高风险域
- Profile 默认关闭：仅在用户显式启用或满足启用条件时生效
- Router/Scenarios 说明：明确不依赖 skills 体系，并说明“如何路由到场景闭环”（可为手工路由口径）
- Project Rules 说明：明确其可选属性与适用条件（Task Record、repo-local controller 等）
- Project Assets 说明：明确 `dist/project-assets/**` 为可选复制资产包

### Trae（skills 入口）

对以下入口 Skill 做抽查即可：

- `laravel-agent-global`：必须包含 Hard 治理与交付输出格式（或要求输出格式）
- `laravel-agent-router`：必须包含 routing priority、Scene/Stage/TaskId 参数补齐、Stop Conditions 的停下策略
- `laravel-agent-project`：必须明确其为“项目工作流约定”，且不会覆盖 Hard
- Profile skills：必须明确“默认不启用”与启用条件

### Qoder（.qoder 入口）

抽查 `.qoder/agents/laravel-agent.md`：

- 明确推荐组合：router + global +（可选）project
- 明确 Profile 的显式启用方式，并要求在输出中说明“Profile 已启用/生效点”
- 明确交付输出格式（Scope/Task Level/Plan/Implement/Verify）

## 3) Project Assets（可选安装）核对点

- `dist/project-assets/**` 仅提供脚本/模板等附属资产，不影响最小安装可用性
- 入口文件/安装文档必须说明其用途与“可选”属性，避免用户误认为必须安装
- 资产复制到项目后应由团队自行约定存放目录与调用方式（避免硬编码工具路径）

## 4) 偏差与修复策略（规则包内）

允许的修复手段（不改源文件边界）：

- dist 结构或入口描述不一致：只调整 `laravel-agent-kit/dist/**`、`laravel-agent-kit/docs/**`、`laravel-agent-kit/adapters/**`
- 若出现破坏性变更风险：在对应文档中标记 **BREAKING** 并给出迁移说明（旧安装方式如何继续工作/如何升级）

