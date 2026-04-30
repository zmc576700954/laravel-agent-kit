---
name: laravel-agent-profile-owl-admin-profile
description: Profile：OwlAdmin 存量项目的迁移/维护协作框架（默认不启用，占位版）。
tags:
  - laravel
  - profile
  - owladm
metadata:
  kind: profile
  default_enabled: false
  requires:
    - laravel-agent-global
---

# Profile：OwlAdmin（占位）

## Discovery

1) 启用条件（默认不启用）
- 项目存在 OwlAdmin 存量后台（例如目录/命名空间 `app/Admin/**` 或等价结构）
- 任务与 OwlAdmin 存量维护或向新后台（例如 Filament）迁移规划直接相关
- 用户在 Prompt 中明确声明“本次启用 OwlAdmin Profile”

2) 模块感知（单体 vs 多模块，默认不扩扫）
- 最小读取：`composer.json`、OwlAdmin 存量代码的入口（例如 `app/Admin/**`）、与本次任务直接相关的 admin service。
- 若项目为多模块：先确认 OwlAdmin 存量位于哪个模块根目录；后续落点与读取列表以模块根为基准。

## Role split

- Legacy Admin Maintenance：只做必要维护，不进行结构性重构。
- Migration Planning（如适用）：先定义迁移边界与不变量，再决定落点与批次推进方式。
- Contract Guard：任何涉及接口契约、权限边界、数据口径的变更都必须先明确验收与回滚方案。

## Related items

- 目录与真相源：OwlAdmin 的入口与注册位置、路由/菜单/权限配置落点（以项目为准）。
- 迁移目标：若迁移到 Filament，建议配合启用 Filament Admin 迁移 Profile，并遵守其 Actions/目录约束。
- 热文档（可选）：若项目有迁移任务池/热文档，必须由用户指定真相源与写入授权。

## Verify

- `php -l <changed-files>`
- 若涉及路由/注册：`php artisan route:list --path=<keyword>`
- 若项目有测试：`php artisan test` 或 `vendor/bin/pest`

## Stop Conditions

- 需要推进迁移批次或写入热文档/任务池但未获得明确授权
- 需要改变数据库结构、接口契约、权限真相源或数据口径但边界不清晰
- 需要新增依赖或升级关键依赖版本
- 需要执行整体迁移/整体回滚
- 涉及生产配置、密钥、第三方凭据或中文正文写入风险

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
- Hard Invariants: (占位：本次启用后生效的不变量框架)
- Risk & Rollback: (Heavy 必填；其他可选)

Implement:
- (按 Plan 执行；确保不扩大范围)

Verify:
- (命令优先；否则最小人工验证清单)
```

