---
name: laravel-agent-scenario-api-endpoint
description: 新增或扩展 Laravel API/HTTP Endpoint 的闭环剧本（模块感知，含路由/校验/鉴权/资源/测试）。
tags:
  - laravel
  - scenario
  - api
metadata:
  kind: scenario
  requires:
    - laravel-agent-global
---

# 新增 API 接口（api-endpoint）

## Discovery

1) 确认范围与验收
- 让用户给出：路由（method + path）、请求字段、响应结构、鉴权规则、验收标准、允许修改的目录/文件。

2) 模块感知（单体 vs 多模块，默认不扩扫）
- 最小读取：`composer.json`、`routes/api.php`（或用户指定的 routes 文件）、`app/Providers/RouteServiceProvider.php`（如存在）。
- 判断是否为多模块：是否存在模块根目录（常见：`modules/`、`Modules/`、`packages/`、`src/Modules/`）或 composer autoload 显示多模块命名空间。
- 若为多模块：先确定目标模块根目录与命名空间；后续所有落点（routes/controller/request/tests）都以模块根为基准。

3) API 组织方式与既有风格
- 路由落点：`routes/api.php` 或模块内 routes 文件；确认版本前缀（如 `/api/v1`）与命名约定。
- Controller 风格：先找同类 API Controller 作为模板（命名空间、返回结构、异常处理）。
- 校验方式：优先 Form Request（或项目既有方式）；确认 422 错误结构是否有统一封装。
- 鉴权方式：优先 Policy/Gate/中间件；确认“管理员”的真相源（role/permission/guard）。
- 输出方式：优先 API Resource（或项目既有 transformer/response helper）。
- 测试框架：通过 `composer.json` 与 `tests/` 目录判断 Pest vs PHPUnit，并沿用既有测试风格。

## Role split

- Route：新增/调整路由定义（method/path、name、middleware、版本前缀）。
- Controller：保持薄，只做协调与调用；不把复杂业务塞进 Controller。
- Form Request：请求校验与 authorize（若项目习惯把鉴权放在 Request）。
- Service（可选）：承载业务用例编排（事务边界、聚合写入、事件触发）。
- Model/Query：提供数据访问与关系加载；为后续性能（N+1）预留 eager load。
- Resource/Response：稳定输出结构；避免随手改契约。
- Policy/Gate/Middleware：权限边界与敏感字段处理。
- Tests：至少覆盖成功/失败（403/422/404/409 等）关键路径；让验证可执行。

## Related items

- 路由：版本前缀、name、middleware、rate limit、CORS（若项目已有）。
- 数据：migration（仅在需要时）、factory/seeder、model casts/enum、事务边界。
- 鉴权：guard、policy 注册、权限表/role 常量、管理员判定方式。
- 输出契约：Resource、分页结构、错误码语义、字段命名（snake/camel）。
- 兼容性：PHP/Laravel 版本、数据库方言、旧客户端兼容策略。

## Verify

- `php -l <changed-files>`
- 路由相关：`php artisan route:list --path=<keyword>`
- 测试：`php artisan test` 或 `vendor/bin/pest`
- 若项目存在格式化/静态分析门禁：按项目既有命令执行（例如 Pint/PHPStan/Psalm/PHPCS）

## Stop Conditions

- 需要新增 Composer 依赖或升级关键依赖版本
- 需要改变 API 契约（路由/字段/响应结构/错误码语义/分页或过滤语义）
- 需要改变权限模型真相源或扩大可访问范围
- 需要执行整体迁移/整体回滚（`migrate`/`rollback`/`fresh`/`refresh`/`reset`）
- 涉及中文正文/生成文件/热文档写入风险
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
- (按 Plan 执行；禁止扩大范围)

Verify:
- (命令优先；否则最小人工验证清单)
```

## Task Record（可选）

当任务需要留痕（中/重任务，或用户明确要求记录过程）时，输出一份任务记录（可内联或单独文件），模板参考：`project/assets/task-doc-template.md`。
