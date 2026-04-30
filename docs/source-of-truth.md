# Vendor-neutral 源文件清单（Source of Truth）

目标：用一套“与工具无关”的源文件维护 Laravel Agent 的规则体系，再按不同 AI 工具（Claude/Codex/OpenCode/Trae/Qoder）生成可直接安装的入口文件与目录（dist）。这样可以避免多份入口文件漂移，降低维护成本。

## 1. 源文件（必须 vendor-neutral）

以下文件是唯一真相源（Source of Truth）。它们不包含任何特定工具的安装路径、文件名（如 `AGENTS.md` / `CLAUDE.md`）或工具专用导入语法。

**Global（跨项目通用）**
- `global/baseline.md`：Laravel 社区/官方实践的“技术质量底线”（不含项目治理、不含业务名词）
- `global/reality-layer.md`：通用治理能力（范围控制、任务分级、迁移安全、中文编码、验证闭环、Stop Conditions）
- `global/prompt-generator-rules.md`：Prompt 生成器的规则（如何从自然语言整理成可执行任务）
- `global/prompt-templates.md`：面向用户/产品的 Prompt 模板（Feature/Bugfix/Refactor/Performance/Explain）
- `global/review-checklist.md`：质量与安全自检清单（Agent 自检/PR 自检）

**Project（仓库绑定的操作性规则）**
- `project/rules.md`：显式参数（Scene/Stage/TaskId）、repo-local controller 约定、Task Record 约定
- `project/assets/*`：脚本与模板等附属资产（可选安装；由 dist 映射到项目目录）

**Skills（场景 / Profile，可安装）**
- `skills/*/SKILL.md`：场景 Skill 与 Profile Skill 的唯一真相源，采用 Agent Skills 标准（YAML frontmatter + markdown body）。内容保持工具无关；工具只要求“能读取 SKILL.md”。
 - `skills/index.md`：技能索引（帮助用户选型，不属于工具产物入口）

**Profiles（按需启用，legacy）**
- `profiles/*.md`：历史遗留的 Profile 文档（可作为参考/迁移来源）；以 `skills/` 中的 Profile Skill 为准。

## 2. 非源文件（可删可改，不影响规则一致性）

- `dist/**`：工具入口文件与可复制粘贴目录（从源文件“生成/拼装/复制”而来；不应作为编辑入口）
- `adapters/**`：各工具的入口映射、安装路径与限制（工具相关信息只放这里）
- `docs/**`：安装、升级、回滚、示例与维护说明

## 3. 命名与放置规则（维护约束）

- **不绑定工具**：源文件避免出现“Claude/Codex/OpenCode/Trae/Qoder”等字样；工具相关内容写入 `adapters/**` 或 `docs/**`。
- **不绑定安装路径**：源文件禁止出现“项目根目录/全局目录/~/.codex”等路径描述；路径与映射写入 `adapters/**`。
- **不引用 dist 产物**：源文件之间可以互相引用（相对路径），但不要引用 `dist/**`，避免反向依赖。
- **Profile 只写差异**：Profile 只包含项目不变量、启用条件与最小验证口径；不要复制 Global 内容。
- **优先复用而非复制**：新增规则先判断属于 Global 还是 Profile；避免在多个 Profile 里重复相同规则。

## 4. 与现有文档的对应关系（溯源）

本 Kit 复用并迁移自现有文档（原始位置不要求删除）：

- `docs/ai/laravel-agent/merge-report.md` → `global/baseline.md`（提炼 baseline 规则清单与来源）
- `docs/ai/laravel-agent/reality-layer.md` → `global/reality-layer.md`
- `docs/ai/laravel-agent/prompt-generator-rules.md` → `global/prompt-generator-rules.md`
- `docs/ai/laravel-agent/prompt-templates.md` → `global/prompt-templates.md`
- `docs/ai/laravel-agent/review-checklist.md` → `global/review-checklist.md`
- `docs/ai/laravel-agent/profiles/bargain-system-filament-migration.md` → `profiles/filament-admin-migration.md`
- `docs/ai/laravel-agent/demo-run.md` → `docs/examples/laravel-minimal.md`（最小可验证样例）
