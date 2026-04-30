---
name: laravel-agent-scenario-testing-pest-phpunit
description: Laravel 测试补齐闭环（Pest/PHPUnit 自适应：先识别框架与风格，再补关键用例，让验证可执行）。
tags:
  - laravel
  - scenario
  - testing
metadata:
  kind: scenario
  requires:
    - laravel-agent-global
---

# 测试补齐（testing-pest-phpunit）

## Discovery

1) 明确验收标准与关键路径
- 成功路径（200/201 等）与至少 1–2 个关键失败路径（403/422/404/409 等）。
- 明确“不允许改变”的内容：接口契约、权限边界、数据口径、用户可见行为。

2) 模块感知（单体 vs 多模块，默认不扩扫）
- 最小读取：`composer.json`、`phpunit.xml`/`phpunit.xml.dist`（如存在）、`tests/` 目录结构（仅必要）、同目录同类测试文件作为模板。
- 判断 Pest vs PHPUnit：依赖、测试文件风格、基类与 helper。
- 多模块：确认测试是否在模块内或集中在根 tests 目录；按项目惯例放置测试。

3) 选定测试类型与最小准备
- API/HTTP：优先 Feature 测试；复用既有 helper（登录、seed、factory）。
- Domain：仅在项目已有 Unit 测试体系时再写更细粒度单元测试。
- 数据准备：优先 factory；避免引入复杂 fixture 或大范围 seed（除非项目已有）。

## Role split

- Arrange：准备最小数据与身份（管理员/普通用户/未登录）。
- Act：发起请求或调用用例入口。
- Assert：断言 status、关键字段、错误结构与副作用（数据库写入、事件触发）。
- Regression：覆盖最近修复/新增的关键行为，避免“只测 happy path”。

## Related items

- 鉴权：policy/gate/middleware；测试中用最小身份切换覆盖 403。
- 校验：Form Request/validator；测试中覆盖 422 错误结构与字段提示（按项目既有格式）。
- 数据一致性：enum/casts、默认值、时区与时间格式。
- 测试性能：必要时用 refresh database/transactions（按项目既有配置），避免全量 seed。

## Verify

- 测试：`vendor/bin/pest` 或 `php artisan test`（以项目为准）
- `php -l <changed-files>`
- 若 CI 有门禁：按项目既有命令补充（例如 Pint/PHPStan 等）

## Stop Conditions

- 需要新增测试相关依赖或升级关键依赖版本
- 需要执行整体迁移/整体回滚或依赖生产数据回填
- 需要改变接口契约、权限边界、数据口径或用户可见行为
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
- Add/Update Tests:
- Data Setup:
- Risk & Rollback: (Heavy 必填；其他可选)

Implement:
- (先识别 Pest/PHPUnit 与既有风格，再补关键用例；禁止扩大范围)

Verify:
- (测试命令 + 关键断言点摘要)
```

## Task Record（可选）

当任务需要留痕（中/重任务，或用户明确要求记录过程）时，输出一份任务记录（可内联或单独文件），模板参考：`project/assets/task-doc-template.md`。
