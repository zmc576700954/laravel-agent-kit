---
name: laravel-agent-scenario-bug-fix
description: Laravel Bug 修复与回归闭环（先复现，再最小修复，再验证与回归；模块感知，默认不扩扫）。
tags:
  - laravel
  - scenario
  - bug
  - fix
metadata:
  kind: scenario
  requires:
    - laravel-agent-global
---

# 代码修复与回归（bug-fix）

## Discovery

1) 复现优先
- 若已有复现步骤/测试：先跑出失败信号，记录期望与实际。
- 若无复现：优先补一个最小复现用例（Feature 测试或最小请求样例），让修复可验证。

2) 模块感知（单体 vs 多模块，默认不扩扫）
- 最小读取：`composer.json`、问题入口（routes/controller/command/job）、失败栈中涉及的文件、对应测试目录。
- 多模块：先确定模块根目录与命名空间；修复与回归仅在模块内 + 必要 shared 层范围内进行。

3) 回归范围
- 明确需要覆盖的回归用例（成功路径 + 失败路径 + 边界条件）。
- 明确“不能改变”的内容：接口契约、权限边界、数据口径、用户可见行为。

## Role split

- Repro/Test：建立或最小化复现用例（最好能自动化）。
- Fix：最小补丁修复（不顺手重构；不引入无关抽象）。
- Guardrails：必要时补充输入校验、空值处理、enum/cast、关系 eager load（仅限本 bug 所需）。
- Regression：补齐关键回归测试，覆盖已修复的失败信号与最关键的成功路径。

## Related items

- 校验：Form Request、validator、request->validated 的使用方式。
- 错误处理：统一响应结构、异常转换、404/403/422/409 语义一致性。
- 数据：nullable/default、casts、enum、迁移口径与历史脏数据。
- 并发：唯一约束、事务、幂等、重试（仅在证据指向时涉入）。

## Verify

- `php -l <changed-files>`
- 测试：`php artisan test` 或 `vendor/bin/pest`
- 若修复涉及路由/注册：`php artisan route:list --path=<keyword>`
- 若无法运行命令：提供最小人工回归清单（接口样例/页面路径/关键断言）

## Stop Conditions

- 修复需要改变接口契约、权限边界、数据口径或用户可见行为时
- 修复需要新增依赖或升级关键依赖版本时
- 修复需要执行整体迁移/整体回滚或进行不可逆数据回填时
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
- Repro:
- Fix:
- Regression:
- Risk & Rollback: (Heavy 必填；其他可选)

Implement:
- (先让 bug 可复现，再修复，再验证复现消失)

Verify:
- (复现用例通过 + 回归用例通过)
```

## Task Record（可选）

当任务需要留痕（中/重任务，或用户明确要求记录过程）时，输出一份任务记录（可内联或单独文件），模板参考：`project/assets/task-doc-template.md`。
