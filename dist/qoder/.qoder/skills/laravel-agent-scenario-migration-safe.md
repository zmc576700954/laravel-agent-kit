---
name: laravel-agent-scenario-migration-safe
description: Laravel 数据库迁移与数据口径安全闭环（迁移策略、回滚路径、最小可验证执行；默认禁止整体迁移/回滚）。
tags:
  - laravel
  - scenario
  - migration
metadata:
  kind: scenario
  requires:
    - laravel-agent-global
---

# 数据库迁移与数据口径（migration-safe）

## Discovery

1) 明确“结构变更”与“数据口径”
- 结构变更：新增/修改字段、索引、约束、表关系。
- 数据口径：默认值、回填规则、历史数据兼容、线上/离线执行策略。
- 让用户明确：数据库类型、目标环境、是否允许执行迁移命令（默认不允许整体迁移/整体回滚）。

2) 模块感知（单体 vs 多模块，默认不扩扫）
- 最小读取：`composer.json`、`config/database.php`（如用户允许）、既有 migration 命名风格、目标 model/表相关代码（仅必要）。
- 多模块：确认 migrations 是否集中在根 `database/migrations` 或模块内自带 migrations；所有落点按真实目录执行。

3) 迁移策略与回滚路径（先设计再写）
- 迁移是否可回滚：down 方法、可逆性、是否需要分两步（先 nullable/backfill 再加约束）。
- 风险识别：锁表、长事务、线上回填、索引创建耗时、默认值兼容。
- 执行边界：默认只允许“单迁移文件定向执行”，并记录执行证据。

## Role split

- Migration：只包含必要的 schema 变更与回滚逻辑，遵循既有命名与目录习惯。
- Data backfill（可选）：若需要回填，优先使用可控脚本/command/job（取决于项目惯例），并明确幂等性与可回退策略。
- Model/Cast：同步更新 model casts/enum/default（仅当与迁移直接相关）。
- Tests（可选）：为关键口径提供最小验证（例如创建/更新行为、默认值、约束失败语义）。

## Related items

- 约束：unique/foreign key、on delete 行为、nullable 与默认值。
- 性能：索引策略、线上迁移窗口、批量回填的 chunk/batch。
- 契约：接口字段是否随迁移变化；若变化，先触发 Stop Conditions。
- 多环境：本地/CI/生产的迁移策略差异（禁止默认假设可直接跑生产迁移）。

## Verify

- `php -l <changed-files>`
- 迁移（仅在明确授权后）：`php artisan migrate --path=database/migrations/<filename>.php`
- 回滚策略说明（不默认执行）：`php artisan migrate:rollback --path=...`（如框架版本支持；否则给出替代回滚方案）
- 若项目有测试：`php artisan test` 或 `vendor/bin/pest`

## Stop Conditions

- 需要执行整体迁移/整体回滚（`migrate`/`rollback`/`fresh`/`refresh`/`reset`）
- 需要不可逆的数据回填或线上大批量更新策略不明确
- 需要改变数据口径但验收与影响范围不清晰
- 需要改变接口契约、权限边界或用户可见行为
- 需要新增依赖、写入热文档/中文正文、触及生产配置/密钥/第三方凭据

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
- Migration Strategy:
- Backfill Strategy: (如适用)
- Rollback Strategy:
- Risk & Rollback: (Heavy 必填；其他可选)

Implement:
- (先写迁移与回滚逻辑，再处理回填与联动代码；禁止扩大范围)

Verify:
- (迁移定向执行命令/测试命令/最小人工验证清单)
```

## Task Record（可选）

当任务需要留痕（中/重任务，或用户明确要求记录过程）时，输出一份任务记录（可内联或单独文件），模板参考：`project/assets/task-doc-template.md`。
