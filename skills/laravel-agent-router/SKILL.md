---
name: laravel-agent-router
description: Laravel 工作默认入口与兜底路由（专用场景 Skill 优先；严格治理需显式触发；优先显式 Scene/Stage/TaskId）。
tags:
  - laravel
  - router
  - entry
metadata:
  kind: router
  requires:
    - laravel-agent-global
---

# Laravel Router（默认入口与兜底）

## 目标

在用户没有明确指定使用哪个场景 Skill 时，给出“该用哪个 Skill”的判定与下一步所需的显式参数（Scene/Stage/TaskId）。本 Skill 不负责覆盖专用 Skill 的内容，只负责路由与兜底。

## Routing priority

1. 专用场景 Skill 优先：请求明显命中某个场景时，必须让位给该 Skill。
2. Profile 默认不启用：只有用户明确启用，或请求显式命中 Profile 的启用条件时才建议启用。
3. 严格治理/热文档/编号任务：只有在用户显式要求时才进入重流程；否则保持轻量闭环。

## 显式参数优先

优先提示用户提供或确认以下参数：

- Scene：`filament-migration` / `bugfix` / `feature-admin` / `feature-api` / `cleanup` / `normal-dev`
- Stage：`context` / `execution` / `review` / `closeout`
- TaskId：有编号任务时显式提供；无编号任务时留空

## 场景命中规则（关键词 → Skill）

- 新增/扩展 API、routes、endpoint、resource、FormRequest、API 测试 → `laravel-agent-scenario-api-endpoint`
- 修改既有逻辑、调整行为、补字段、改查询、改页面逻辑（不新增完整功能）→ `laravel-agent-scenario-change-existing`
- “为什么坏了/定位/复现/日志/报错分析/缩小范围”→ `laravel-agent-scenario-bug-triage`
- “修复 bug/修回归/修测试/修生产问题”→ `laravel-agent-scenario-bug-fix`
- migration、schema、数据口径、回滚、索引、约束 → `laravel-agent-scenario-migration-safe`
- N+1、慢查询、SQL、eager load、缓存命中、性能 → `laravel-agent-scenario-performance-nplus1`
- Pest/PHPUnit、补测试、回归、CI 失败（测试类）→ `laravel-agent-scenario-testing-pest-phpunit`

## 输出要求（路由结果）

最终输出必须包含：

1. 推荐的目标 Skill（一个主 Skill；可附带可选 Profile）
2. 建议的 Scene/Stage/TaskId（缺失则列出最小追问）
3. 简短的 In Scope / Out of Scope
4. 若触发 Stop Conditions，必须先停下确认
