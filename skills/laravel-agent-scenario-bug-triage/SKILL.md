---
name: laravel-agent-scenario-bug-triage
description: Laravel Bug 排查与定位闭环（先复现与证据收集，再缩小范围定位根因，模块感知，默认不扩扫）。
tags:
  - laravel
  - scenario
  - bug
  - triage
metadata:
  kind: scenario
  requires:
    - laravel-agent-global
---

# Bug 排查与定位（bug-triage）

## Discovery

1) 收集最小证据（先问清再动手）
- 复现条件：请求样例（method/path/body/headers）、用户身份/权限、数据前置条件、期望 vs 实际。
- 错误信号：异常栈、日志片段、HTTP status、错误码、发生频率（必现/偶发）。
- 影响范围：仅某模块/某租户/某数据集/某环境。

2) 模块感知（单体 vs 多模块，默认不扩扫）
- 最小读取：`composer.json`、与问题最近的入口（routes/controller/command/job）、以及异常栈中出现的文件。
- 若为多模块：先确定目标模块根目录；排查只在目标模块 + 必要的 shared 层范围内进行。

3) 缩小范围：从入口到数据链路画清楚
- 入口：route/controller/middleware/request authorize。
- 业务链路：service/action/use case。
- 数据链路：model/query/relationship/resource serialization。
- 旁路：events/listeners/queues/cache（仅在证据指向时才涉入）。

## Role split

- Repro：用最小输入复现（请求样例或最小测试），保证“可验证”。
- Evidence：把关键证据归档到输出（栈顶、关键变量、SQL/关系访问点位）。
- Narrow down：把问题拆成可验证假设，一次只验证一个假设。
- Root cause：定位到具体函数/条件分支/数据字段来源，并给出“最小修复建议”。

## Related items

- 日志与异常：Laravel handler、自定义 exception、统一响应封装（若项目有）。
- 数据一致性：脏数据、nullable 字段、enum/cast、默认值与迁移口径。
- 权限与中间件：guard、policy/gate、tenant scope、rate limit。
- 性能副作用：排查时注意 N+1、慢查询与序列化触发的关系访问。

## Verify

- 最小复现验证：写/改一个最小测试（Feature 优先；或最小脚本/请求样例）
- `php -l <changed-files>`（如果排查过程中做了最小修复或添加了复现用例）
- 测试：`php artisan test` 或 `vendor/bin/pest`（若环境允许）

## Stop Conditions

- 没有足够证据却需要扩扫/扫描全项目时，先停下说明阻断点
- 需要改变接口契约、权限边界、数据口径或迁移策略时，先停下确认
- 需要新增依赖、写入热文档/中文正文、触及生产配置/密钥时，先停下确认

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
- Repro:
- Narrow down:
- Risk & Rollback: (Heavy 必填；其他可选)

Implement:
- (只做定位所必需的最小改动；如进入修复阶段转用 bug-fix)

Verify:
- (复现用例是否消失 / 测试是否通过)
```

## Task Record（可选）

当任务需要留痕（中/重任务，或用户明确要求记录过程）时，输出一份任务记录（可内联或单独文件），模板参考：`project/assets/task-doc-template.md`。
