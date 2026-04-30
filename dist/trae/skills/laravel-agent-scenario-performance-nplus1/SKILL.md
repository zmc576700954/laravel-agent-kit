---
name: laravel-agent-scenario-performance-nplus1
description: Laravel 性能排查与 N+1 问题闭环（先量化与定位，再最小优化并给出可验证对比）。
tags:
  - laravel
  - scenario
  - performance
  - nplus1
metadata:
  kind: scenario
  requires:
    - laravel-agent-global
---

# 性能排查与 N+1（performance-nplus1）

## Discovery

1) 明确“慢”的可观测口径
- 请求/页面路径、慢到什么程度（响应时间/查询次数/CPU/内存/队列耗时）。
- 证据来源：日志、APM、SQL 输出、debugbar、`DB::listen`（以项目既有方式为准）。

2) 模块感知（单体 vs 多模块，默认不扩扫）
- 最小读取：`composer.json`、目标入口（routes/controller/page/command/job）、相关 Resource/View、对应 Query/Model。
- 多模块：先确定目标模块根目录；排查只在模块内 + 必要 shared 层范围内进行。

3) 定位“查询触发点”
- 列表/聚合：确认是否在循环中访问关系属性或调用会触发 lazy loading 的方法。
- Resource/Transformer：确认序列化过程中是否访问未 eager load 的关系。
- 过滤/排序：确认是否触发额外查询或缺少索引（仅在证据指向时）。

## Role split

- Measure：用项目既有手段量化（查询次数/关键 SQL/响应时间），形成“优化前基线”。
- Locate：定位触发 N+1 的具体访问点（资源序列化/循环/关系访问）。
- Fix：最小修改（eager load、select 约束、withCount、预加载嵌套关系），不改变业务语义。
- Validate：给出“优化前 vs 优化后”的可对比证据（查询次数减少/关键 SQL 合并/耗时下降）。

## Related items

- Eloquent：`with()`、`load()`、`withCount()`、`withExists()`、`select()`、`chunk()`。
- 关系：命名是否一致、是否有默认 eager load、是否允许 lazy loading（项目可能禁用）。
- 分页：分页结构与默认排序，避免“为了性能顺手改语义”。
- 缓存/队列：属于更大策略变更，默认不启用；需要时先触发 Stop Conditions。

## Verify

- `php -l <changed-files>`
- 测试：`php artisan test` 或 `vendor/bin/pest`（若项目有相关用例）
- 对比证据（择一，按项目可用性）：
  - 输出/记录查询次数（debug/日志/APM）
  - 对比关键 SQL 数量与耗时
  - 对比接口响应时间（同数据集/同身份）

## Stop Conditions

- 需要引入缓存/队列/异步化等架构策略变更
- 需要改变分页/过滤/排序语义或响应结构
- 需要新增依赖或升级关键依赖版本
- 需要执行迁移、增删索引或进行数据回填但策略不明确
- 涉及生产配置/密钥/第三方凭据或热文档/中文正文写入风险

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
- Baseline:
- Optimize:
- Compare:
- Risk & Rollback: (Heavy 必填；其他可选)

Implement:
- (先建立可对比基线，再做最小优化，再输出对比证据)

Verify:
- (测试命令 + 对比证据)
```

## Task Record（可选）

当任务需要留痕（中/重任务，或用户明确要求记录过程）时，输出一份任务记录（可内联或单独文件），模板参考：`project/assets/task-doc-template.md`。
