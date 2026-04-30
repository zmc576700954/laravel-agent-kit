# 升级与回滚策略

目标：在升级 Kit 规则时，不覆盖项目自定义，并且可以快速回滚到已验证版本。

## 升级（copy 安装）

推荐流程：

1. 拉取新版本 Kit（建议使用 tag/版本号）。
2. 对比变更：重点对比 `dist/<tool>/` 与 `global/`、`profiles/` 的差异。
3. 将新的 `dist` 入口文件/目录复制到项目中。
4. 若项目对入口文件有自定义：
   - 将自定义集中在一个明确区块（例如 “Project Overrides”），升级时人工合并；
   - 或将自定义拆分到单独文件，并在团队流程中约定合并方式（取决于你的工具能力）。
5. 升级后进行一次最小验证：让 Agent 执行一个小任务，检查是否输出 Scope/Task Level/Plan/Implement/Verify，且 Stop Conditions 能触发“先停下确认”。

## 升级（symlink 安装）

推荐流程：

1. 在 Kit 仓库切换到新 tag/commit（`git fetch --tags` → `git checkout <tag>`）。
2. 让项目里的入口 symlink 保持不变，规则自动更新。
3. 做一次最小验证（同上）。

## 回滚

### 基于 git tag/commit（推荐）

1. 记录当前可用版本（tag 或 commit SHA）。
2. 出现问题时，将 Kit 仓库切回旧 tag/commit：
   - copy 安装：重新复制旧版 dist 到项目
   - symlink 安装：切回旧 tag/commit 后项目自动回滚

### 基于备份（兜底）

在升级前备份项目内的入口文件/目录：

- `CLAUDE.md` / `AGENTS.md`
- `.qoder/`
- 以及任何你追加的 Profile 内容

出现问题时直接恢复备份。

## 与 skill 安装工具的兼容（不强依赖）

本 Kit 的 Trae 产物遵循“目录 + `SKILL.md`”的通用约定，因此可兼容常见的 skill 安装器（例如 skill4agent 类工具）：

- Kit 不要求使用安装器；只要你能把 `dist/trae/skills/<skill>/` 放到工具识别的 skills 路径即可。
- 若安装器支持版本管理：建议以 git tag 作为版本来源，按 tag 升级/回滚。

