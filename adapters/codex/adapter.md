# Adapter：Codex

## 入口识别

- Codex 识别项目根目录 `AGENTS.md` 作为项目级规则入口。
- 部分环境支持全局入口（例如用户目录下的固定位置），用于跨项目复用 Global 规则。

## 安装路径

- 项目级：项目根目录 `AGENTS.md`
- 全局级（可选）：以你的 Codex 安装说明为准（例如 `~/.codex/AGENTS.md`）

## 最小可用安装

- 复制 `dist/codex/AGENTS.md` → 项目根目录 `AGENTS.md`

## 推荐安装组合

- 仅项目级 `AGENTS.md`（最稳妥，Hard 不会被覆盖）
- 如你的环境支持“全局 + 项目级”：
  - 全局入口：放 Global（Hard + Baseline + 输出契约）
  - 项目入口：放项目特定内容（Project Rules、局部约束、Profile 启用声明）

## Router / Project / Profiles / Scenarios（组合规则）

- `dist/codex/AGENTS.md` 为可直接复制粘贴版本，包含 Global 规则与 Profile 启用说明。
- 如你的环境同时使用全局与项目级入口：建议将 Global 放全局，把项目特定内容留在项目 `AGENTS.md`；并在项目文件中明确“优先级与覆盖方式”。
- Codex 不假设支持 skills：Router/Scenarios 以入口文件内的规则与用户提示进行“手工路由”。

## Project Assets（可选）

- 通用资产包位置：`dist/project-assets/**`
- 用途：脚本/模板等附属资产；不影响最小安装可用性

## 限制与兼容性

- 不假设支持多文件拼接或 include/import；dist 产物为单文件可用版本。

## 升级/回滚注意点

- 升级时优先对比 `dist/codex/AGENTS.md` 与你项目内 `AGENTS.md` 的差异，避免覆盖项目自定义段落。
