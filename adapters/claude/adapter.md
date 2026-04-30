# Adapter：Claude Code

## 入口识别

- Claude Code 默认识别项目根目录的 `CLAUDE.md` 作为工作约束与交付格式。

## 安装路径

- 项目级：项目根目录 `CLAUDE.md`

## 最小可用安装

- 复制 `dist/claude/CLAUDE.md` → 项目根目录 `CLAUDE.md`

## 推荐安装组合

- `CLAUDE.md`（全量内联规则，可直接使用）
- （可选）按需启用 Project Rules（入口文件内已有段落）
- （可选）按需启用 Profile（手工追加 Profile 内容 + 在 Prompt 中显式声明启用）

## Router / Project / Profiles / Scenarios（组合规则）

- `dist/claude/CLAUDE.md` 为可直接复制粘贴版本，内容已包含 `global/` 的 Baseline + Reality Layer + 模板要点 + Checklist。
- Profile 默认不启用；如需启用，将对应 Profile 的内容追加到 `CLAUDE.md` 的 Profile 区块中，并在任务 Prompt 中明确启用。
- Claude Code 不假设支持 skills：Router/Scenarios 以入口文件内的规则与用户提示进行“手工路由”。

## Project Assets（可选）

- 通用资产包位置：`dist/project-assets/**`
- 用途：脚本/模板等附属资产；不影响最小安装可用性

## 限制与兼容性

- Claude Code 不要求（也不保证）支持 Markdown include/import，因此 dist 产物采用“完整内联”的方式避免依赖。

## 升级/回滚注意点

- 升级时优先用 `git diff` 对比你的 `CLAUDE.md` 与 Kit 的 `dist/claude/CLAUDE.md`，避免覆盖项目自定义段落。
