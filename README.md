# Laravel Agent Kit

一个可作为 git 仓库分发的“Laravel Agent 规则包”，用 vendor-neutral 源文件维护规则体系，并输出可直接复制粘贴安装到不同 AI 工具的入口文件（dist）。

## 目录结构

- `global/`：跨项目通用规则（唯一真相源）
- `project/`：仓库绑定的操作性规则与附属资产（脚本、模板、任务记录规范等）
- `profiles/`：按需启用的项目/场景 Profile（唯一真相源）
- `adapters/`：各 AI 工具入口映射、安装路径、限制与兼容性说明
- `dist/`：可复制粘贴即可用的入口文件与目录（由源文件拼装而来）
- `docs/`：安装、升级/回滚、示例与维护规范

## 快速开始（推荐）

1. 选择你的目标工具，从 `dist/` 复制对应入口文件/目录到项目中。
2. 按 `docs/install.md` 选择 copy 或 symlink 安装方式。
3. 按需启用 `profiles/`（默认不启用）。

## 独立包分发（按工具拆仓库）

若你希望让用户“直接引入某个工具产物仓库”（例如 Codex 直接引入一个根目录包含 `AGENTS.md` 的仓库），可以将 `dist/<tool>/` 作为独立仓库根目录进行分发：

- Claude Code：`dist/claude/`（根目录 `CLAUDE.md`）
- Codex：`dist/codex/`（根目录 `AGENTS.md`）
- OpenCode：`dist/opencode/`（根目录 `AGENTS.md`）
- Trae：`dist/trae/`（根目录包含 `skills/`）
- Qoder：`dist/qoder/`（根目录包含 `.qoder/`）
- 可选资产：`dist/project-assets/`

## 维护原则

- 规则只在 `global/`、`project/`、`skills/` 与 `profiles/`（legacy）维护；`dist/` 视为产物，不作为编辑入口。
- 工具相关内容只写 `adapters/` 与 `docs/`；源文件保持 vendor-neutral。

详见：`docs/source-of-truth.md`、`docs/structure.md`。

## 发布与镜像

发布与“主仓库提交后自动同步到工具子仓库 + Gitee 镜像”见：`docs/publishing.md`。
