# dist 产物映射与生成规则

`dist/` 里的文件/目录面向“安装与使用”，应做到复制粘贴即可用；规则维护只在 `global/`、`skills/`（以及 legacy `profiles/`）进行。

## 契约与核对

- 多工具兼容契约：`docs/adapters/compatibility-contract.md`
- Verification Matrix：`docs/adapters/verification-matrix.md`

## 入口映射

- Claude Code：`dist/claude/CLAUDE.md` → 项目根目录 `CLAUDE.md`
- Codex：`dist/codex/AGENTS.md` → 项目根目录 `AGENTS.md`（可选：将 Global 放到你的 Codex 全局入口）
- OpenCode：`dist/opencode/AGENTS.md` → 项目根目录 `AGENTS.md`
- Trae：`dist/trae/skills/<skill>/SKILL.md` → 安装到 Trae 的 skills 目录
- Qoder：`dist/qoder/.qoder/**` → 项目根目录 `.qoder/**`

## Router / Project / Profiles / Scenarios（组合与优先级）

优先级（高 → 低）：

1. Hard（Global Reality Layer：范围控制/Stop Conditions/迁移安全/中文编码/验证闭环）
2. Project Rules / Project Skill（可选；仓库绑定的工作流约定）
3. Profile（默认不启用；显式启用后生效）
4. Community Baseline（Laravel 工程底线）

组合规则：

- Router 只负责“路由到哪个场景闭环 + 参数补齐（Scene/Stage/TaskId）”，不替代专用场景 Skill
- 若请求明确命中某个场景 Skill：场景 Skill 优先于 Router
- Claude/Codex/OpenCode 不假设支持 skills：Router 与场景闭环以入口文件内的规则与用户提示进行“手工路由”
- Trae/Qoder 支持 skills：推荐使用 Router 作为默认入口，并按需安装场景 skills 与 Project skill

## Skills 映射（Source of Truth → dist）

Skill 的唯一真相源在 `skills/*/SKILL.md`，dist 侧为“可安装复制品”：

- Trae：`skills/<skill>/SKILL.md` → `dist/trae/skills/<skill>/SKILL.md`
- Qoder：`skills/<skill>/SKILL.md` → `dist/qoder/.qoder/skills/<skill>.md`

## Project Rules 与附属资产映射

- Project Rules（文档）：`project/rules.md` → 由各工具入口内联或以单独入口文件承载（取决于工具是否支持多入口）
- Project Assets（可选安装）：`project/assets/**` → `dist/project-assets/**`（用户按需复制到目标项目目录）

## 生成规则（手工可核对）

1. dist 入口文件应**内联** Global 规则的关键内容（至少包含：范围控制、任务分级、迁移安全、中文编码防护、验证闭环、Stop Conditions、交付输出格式）。
2. dist 入口文件必须说明 **Profile 默认不启用**，以及“如何显式启用 Profile”。
3. dist 的工具相关结构（入口文件名、frontmatter、skills 目录）只在 `dist/` 体现；源文件保持 vendor-neutral。
4. dist 的更新流程应可比对：建议使用 `git diff` 对比 `dist/` 与 `global/`/`skills/` 的变化，避免项目自定义被覆盖。
