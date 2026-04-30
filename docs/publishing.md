# 发布与自动同步（GitHub + Gitee 镜像）

目标：

- 主仓库：`laravel-agent-kit`
- 工具子仓库：`laravel-agent-kit-claude`、`laravel-agent-kit-codex`、`laravel-agent-kit-opencode`、`laravel-agent-kit-trae`、`laravel-agent-kit-qoder`、`laravel-agent-kit-assets`
- 要求：主仓库每次提交后，自动同步更新各工具子仓库
- 镜像：在 Gitee 为主仓库与工具子仓库创建镜像

## 1) GitHub 仓库准备

1. 创建主仓库：`laravel-agent-kit`
2. 在同一个 GitHub 组织/用户下创建 6 个工具子仓库（空仓库即可）：
   - `laravel-agent-kit-claude`
   - `laravel-agent-kit-codex`
   - `laravel-agent-kit-opencode`
   - `laravel-agent-kit-trae`
   - `laravel-agent-kit-qoder`
   - `laravel-agent-kit-assets`
3. 各子仓库默认分支建议使用 `main`（与工作流一致）

## 2) GitHub Actions 自动发布（主仓库 → 子仓库）

主仓库已提供工作流：

- `.github/workflows/publish-tool-repos.yml`

它会将以下目录作为“独立仓库根目录”发布到对应子仓库：

- `dist/claude` → `laravel-agent-kit-claude`
- `dist/codex` → `laravel-agent-kit-codex`
- `dist/opencode` → `laravel-agent-kit-opencode`
- `dist/trae` → `laravel-agent-kit-trae`
- `dist/qoder` → `laravel-agent-kit-qoder`
- `dist/project-assets` → `laravel-agent-kit-assets`

### 需要配置的 Secret

在主仓库 GitHub Settings → Secrets and variables → Actions → Secrets 新增：

- `PUBLISH_TOKEN`

要求：

- 该 Token 必须对上述 6 个子仓库具备写入权限
- 推荐使用 Fine-grained PAT，仅授予对这 6 个仓库的 Contents 写权限

## 3) Gitee 镜像（推荐方式：Gitee 镜像 GitHub）

为主仓库与每个工具子仓库各创建一个 Gitee 仓库，并选择“从 GitHub 导入/镜像”：

- 镜像源：对应的 GitHub 仓库地址
- 同步方式：启用自动同步（如 Gitee 提供该选项）

建议镜像仓库命名保持一致：

- `laravel-agent-kit`
- `laravel-agent-kit-claude`
- `laravel-agent-kit-codex`
- `laravel-agent-kit-opencode`
- `laravel-agent-kit-trae`
- `laravel-agent-kit-qoder`
- `laravel-agent-kit-assets`

## 4) Codex 用户“直接引入”方式

Codex 子仓库 `laravel-agent-kit-codex` 的仓库根目录包含：

- `AGENTS.md`
- `README.md`
- `LICENSE`

因此 Codex 用户只需引入该仓库本身即可，不需要再从主仓库手动挑文件。
