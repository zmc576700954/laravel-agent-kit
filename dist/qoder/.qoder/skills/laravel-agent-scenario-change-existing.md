---
name: laravel-agent-scenario-change-existing
description: 在不扩大范围的前提下修改既有 Laravel 功能（模块感知，强调复用现有模式、行为稳定、回归验证）。
tags:
  - laravel
  - scenario
  - change
metadata:
  kind: scenario
  requires:
    - laravel-agent-global
---

# 修改既有功能（change-existing）

## Discovery

1) 明确“既有行为”与“期望行为”
- 让用户给出：当前表现、期望表现、验收标准、允许修改的文件/目录、是否允许改变接口契约/数据口径/权限边界。

2) 模块感知（单体 vs 多模块，默认不扩扫）
- 最小读取：`composer.json`、与目标功能最近的入口文件（routes/controller/command）、以及同目录同类文件作为风格模板。
- 判断是否为多模块：是否存在模块根目录或 composer autoload 暗示模块命名空间。
- 若为多模块：先确定目标模块根目录；所有落点与验证命令按模块内结构组织。

3) 找“既有模式”再改
- 同类功能的实现位置（同路由分组/同 controller/同 service/同 model query）。
- 项目惯例：校验（Form Request）、鉴权（Policy/Gate/中间件）、响应结构（Resource/封装）、错误处理（异常/统一响应）。
- 识别测试框架与既有测试风格（Pest vs PHPUnit、Feature vs Unit、命名与 helper）。

## Role split

- Entry（Route/Controller/Command）：确认真实入口与调用链，不猜测隐藏入口。
- Validation/Auth：在项目既有落点内调整（Request authorize/Policy/Gate/中间件）。
- Domain（Service/Action/UseCase）：仅在项目已有该层时使用；否则按项目现状做最小改动。
- Data（Model/Query/Repository）：只改必要查询与关系加载；避免“顺手重构”。
- Output（Resource/View）：保持输出结构与文案风格一致；避免行为漂移。
- Tests：补/改最小回归用例，让“改动可被验证”。

## Related items

- 行为边界：接口契约、错误码语义、分页/过滤语义、用户可见文案。
- 数据口径：默认不改变既有统计/聚合口径；若必须改变，先触发 Stop Conditions。
- 权限边界：角色/权限真相源、guard、policy 注册与缓存（若项目有）。
- 迁移：仅当需求明确涉及数据结构变更时才引入；默认不执行整体迁移。

## Verify

- `php -l <changed-files>`
- 路由相关：`php artisan route:list --path=<keyword>`
- 测试：`php artisan test` 或 `vendor/bin/pest`
- 若变更影响查询：给出最小人工验证清单（接口调用样例/页面路径）或对比用例（若无法运行测试）

## Stop Conditions

- 需要改变接口契约或用户可见行为边界不清晰
- 需要改变权限模型真相源或扩大可访问范围
- 需要改变数据口径（统计、聚合、默认排序、去重规则）
- 需要新增 Composer 依赖或升级关键依赖版本
- 需要执行整体迁移/整体回滚
- 涉及中文正文/生成文件/热文档写入风险，或生产配置/密钥/第三方凭据

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
- (按 Plan 执行；禁止扩大范围)

Verify:
- (命令优先；否则最小人工验证清单)
```

## Task Record（可选）

当任务需要留痕（中/重任务，或用户明确要求记录过程）时，输出一份任务记录（可内联或单独文件），模板参考：`project/assets/task-doc-template.md`。
