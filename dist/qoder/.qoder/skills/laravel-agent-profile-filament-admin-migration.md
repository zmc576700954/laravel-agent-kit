---
name: laravel-agent-profile-filament-admin-migration
description: Profile：Filament Admin 迁移协作协议（OwlAdmin → Filament 等），默认不启用，满足条件时显式启用。
tags:
  - laravel
  - profile
  - filament
metadata:
  kind: profile
  default_enabled: false
  requires:
    - laravel-agent-global
---

# Profile：Filament Admin 迁移

## Discovery

1) 启用条件（默认不启用）
- 任务属于后台 Admin 迁移（例如 OwlAdmin → Filament）
- 修改 `app/Filament/**` 或与 Filament 资源/页面/组件注册相关的代码
- 任务需要读写“迁移任务池/热文档”，且用户已明确授权本会话写入

2) 模块感知（单体 vs 多模块，默认不扩扫）
- 最小读取：`composer.json`、`app/Filament/**`（仅目标资源/页面相关文件）、与 Admin 迁移直接相关的 service。
- 若项目为多模块：确认 Admin/Filament 代码位于哪个模块根目录；所有落点与读取列表以模块根为基准。

## Role split

- Admin Boundary：迁移默认只动 Admin；禁止顺手扩散到 API。
- Filament Placement：Filament 页面/资源/RelationManagers/Widgets 放在 `app/Filament/**`（或模块内对应路径）。
- Actions API：涉及 `app/Filament/**` 改动时，禁止使用 `Filament\\Tables\\Actions\\*`；统一使用 `Filament\\Actions\\*`。
- Legacy Admin：旧后台目录（如 `app/Admin/**`）只做必要维护；后台新增能力默认使用 Filament。
- Hot Docs（可选）：仅在迁移批次任务中读取并维护用户指定的热文档；未授权会话默认只读。

## Related items

- 边界：不修改数据库结构、接口契约、权限真相源、既有数据口径与用户可见行为（除非用户明确要求）。
- 目录：`app/Filament/**`、`app/Admin/**`、后台相关 `app/Services/**`（以项目为准）。
- 文案一致性：表单、表格、Infolist、页面标题、导航、面包屑、动作文案优先参考同资源或相邻资源既有写法。
- 任务池真相源：迁移任务号/任务池的唯一真相源必须由用户指定；禁止扫描历史推断任务号。

## Verify

- PHP 文件改动后：`php -l <changed-files>`
- 涉及路由/Filament 注册：`php artisan route:list --path=<keyword>`
- 若项目有测试：`php artisan test` 或 `vendor/bin/pest`

## Stop Conditions

- 未经明确要求，任何数据库结构变更、接口契约变更、权限真相源调整
- 需要写入热文档/任务池但未获得明确授权
- 需要新增依赖或升级关键依赖版本
- 需要执行整体迁移/整体回滚
- 涉及生产配置、密钥、第三方凭据

## 闭环输出区块规范

最终交付输出必须包含以下区块（按顺序）：

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
- (按 Plan 执行；确保 Profile 约束被遵守)

Verify:
- (命令优先；否则最小人工验证清单)
```

