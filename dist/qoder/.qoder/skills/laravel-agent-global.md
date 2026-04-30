---
name: laravel-agent-global
description: Laravel 通用治理与技术质量底线（Hard Reality Layer + Baseline），作为所有场景 skills 的基础依赖。
tags:
  - laravel
  - global
metadata:
  kind: global
  requires: []
---

# Laravel Agent（Global）

## Hard：Project Reality Layer（通用治理层）

- 不扫描整个项目；只处理用户明确指定的文件/目录/任务范围；默认不扩扫。
- 最小改动优先：禁止顺手重构、批量清理、抽象升级、目录搬迁或扩大边界。
- 任务分级：轻/中/重；重任务必须写清范围、风险、验证与回退方案。
- Stop Conditions：迁移/权限/API 契约/中文正文写入/依赖/生产配置等触发必须先停下确认。
- 迁移安全：未经授权禁止整体 migrate/rollback；新增迁移默认只允许单迁移文件定向执行并记录执行证据。
- 中文编码防护：保持编码/BOM/换行；避免高风险写入方式；写入后立即复检关键段落。
- 验证闭环：修 bug 先复现→修复→验证；交付必须给出验证命令或最小验证清单。

## Baseline（Laravel 技术约定与质量底线）

- 不新增依赖（除非明确授权）；不假设库存在（以 `composer.json` 与代码证据为准）。
- 不泄露敏感信息（禁止索要或复述密钥、凭据、隐私字段）。
- Controller 保持薄；校验优先 Form Request；鉴权优先 Policy/Gate/中间件。
- API 输出优先 Resource（或项目既有封装）；默认考虑规避 N+1（eager loading）。
- 数据库变更必须走 migration（包含回滚、索引、约束）。
- 新功能默认补测试（Pest/PHPUnit 以项目为准）；交付包含格式化/静态分析（若项目存在 Pint/PHPStan/Psalm/PHPCS 等）。
