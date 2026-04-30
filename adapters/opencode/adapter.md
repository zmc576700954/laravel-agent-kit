# Adapter：OpenCode

## 入口识别

- OpenCode 通常识别项目根目录 `AGENTS.md`。

## 安装路径

- 项目级：项目根目录 `AGENTS.md`

## 最小可用安装

- 复制 `dist/opencode/AGENTS.md` → 项目根目录 `AGENTS.md`

## 推荐安装组合

- `AGENTS.md`（全量内联规则，可直接使用）
- （可选）按需启用 Project Rules（入口文件内已有段落）
- （可选）按需启用 Profile（手工追加 Profile 内容 + 在 Prompt 中显式声明启用）

## Router / Project / Profiles / Scenarios（组合规则）

- `dist/opencode/AGENTS.md` 为可直接复制粘贴版本，内容与 Codex 版本保持同源。
- 如你希望拆分 Global 与 Profile：建议在项目层面维护一个薄封装，Profile 仍需显式启用。
- OpenCode 不假设支持 skills：Router/Scenarios 以入口文件内的规则与用户提示进行“手工路由”。

## Project Assets（可选）

- 通用资产包位置：`dist/project-assets/**`
- 用途：脚本/模板等附属资产；不影响最小安装可用性

## 限制与兼容性

- 不依赖 include/import；dist 产物为单文件版本。

## 升级/回滚注意点

- 升级时优先用 `git diff` 对比你的 `AGENTS.md` 与 Kit 的 `dist/opencode/AGENTS.md`，避免覆盖项目自定义段落。
