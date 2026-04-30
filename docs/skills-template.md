# Skill 模板（Agent Skills SKILL.md）

目标：统一 laravel-agent-kit 内所有场景 Skill/Profile Skill 的结构与输出闭环，便于在 Trae/Qoder/技能安装器中一致加载与使用。

## 1) 文件位置（Source of Truth）

每个 Skill 的唯一真相源放在：

- `skills/<skill-name>/SKILL.md`

## 2) YAML Frontmatter（必须）

所有 `SKILL.md` 顶部必须包含 YAML frontmatter（Agent Skills 标准最小集：`name` 与 `description`）。

示例：

```yaml
---
name: laravel-agent-scenario-api-endpoint
description: 新增或扩展 Laravel API 接口的闭环剧本。
tags:
  - laravel
  - scenario
metadata:
  kind: scenario
  requires:
    - laravel-agent-global
---
```

约束：
- `name` 必须与 skill 目录名一致。
- `description` 用一句话描述闭环目标与适用范围。
- `tags/metadata/compatibility` 可选，但不应写入工具安装路径等 vendor 信息。

## 3) 正文结构（必须）

正文必须包含以下区块（按顺序），且每个区块都要能形成“可执行指令”：

1. Discovery
2. Role split
3. Related items
4. Verify
5. Stop Conditions
6. 闭环输出区块规范
7. Task Record（可选）

### 3.1 Discovery（必须：模块感知 + 最小读取列表）

Discovery 必须先判断项目形态，并在不扩扫前提下确定落点：

- **单体 vs 多模块**：优先读取 `composer.json`（autoload/psr-4）、`routes/`、`app/Providers/RouteServiceProvider.php`（若存在）等“少量关键文件”判断是否存在模块根目录（例如 `modules/`、`Modules/`、`packages/`、`src/Modules/`）。
- **模块落点**：一旦识别模块根目录，后续所有文件落点、命名空间与读取列表都必须以模块根为基准。
- **最小读取列表**：每个 skill 都要列出它允许读取的最小文件集合，并强调“不扩扫”；若必须补读，说明原因与补读边界。

### 3.2 Role split（必须：分工而非拆 Skill）

Role split 的目标是把一个场景拆成多个职责落点（例如 Controller/Request/Service/Model/Resource/Policy/Test），但仍然保持“一个场景一个 Skill”：

- 禁止把 Controller/Service/Model 拆成独立 Skill。
- 分工必须以“当前场景闭环”组织，并明确每个角色的输入/输出与交接点。

### 3.3 Related items（必须：关联项清单）

列出该场景常见的关联项，至少包含：

- 路由/入口（routes、Controller、Console Command）
- 数据层（migration、model、factory、seeder）
- 权限与安全（policy/gate/middleware、敏感字段处理）
- 输出与契约（API Resource、响应结构、错误码语义）
- 文档与变更风险（如适用）

### 3.4 Verify（必须：可执行优先）

Verify 区块必须优先给出可执行命令，并允许在环境受限时给出最小人工验证清单：

- `php -l <changed-files>`
- `php artisan test` 或 `vendor/bin/pest`
- `php artisan route:list --path=<keyword>`（路由相关）
- `php artisan migrate --path=...`（仅在获得授权且为单迁移文件时）

### 3.5 Stop Conditions（必须：强制停下确认）

Stop Conditions 必须覆盖这些类目（可按场景增补）：

- 新增 Composer 依赖或升级关键依赖版本
- 整体 migrate/rollback/fresh/refresh/reset 等迁移策略变更
- 权限模型或接口契约变更（路由/字段/响应结构/错误码语义）
- 涉及中文正文/生成文件/热文档的写入风险
- 生产配置/密钥/第三方凭据相关操作

### 3.6 闭环输出区块规范（必须）

Skill 必须要求最终交付输出包含以下区块（按顺序），并给出每个区块的最小字段：

```text
Scope:
- In Scope:
- Out of Scope:
- Expand Scope: (Yes/No)

Task Level: (Light/Medium/Heavy + 触发依据)

Plan:
- Read:
- Change:
- Risk & Rollback: (Heavy 必填；其他可选)

Implement:
- (按 Plan 执行；禁止扩大范围)

Verify:
- (命令优先；否则最小人工验证清单)
```

### 3.7 Task Record（可选：需要留痕时启用）

当任务需要留痕（中/重任务，或用户明确要求记录过程）时，Skill 应要求产出一份任务记录（可内联或单独文件），至少包含：

- Scene / Pool(or module) / Role / Stage / Status
- Scope / Constraints / Execution Notes / Review Verdict / Closeout Summary

模板参考：`project/assets/task-doc-template.md`。
