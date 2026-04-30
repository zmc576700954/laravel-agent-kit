---
name: laravel-agent-project
description: Laravel 项目级操作性规则（显式 Scene/Stage/TaskId、repo-local controller 约定、Task Record 模板）。
tags:
  - laravel
  - project
  - workflow
metadata:
  kind: project
  requires:
    - laravel-agent-global
---

# Laravel Agent（Project Rules）

本 Skill 用于补齐“在仓库里怎么跑流程”的操作性规范；不替代 Global 的 Hard 约束。

## 显式参数优先（Scene / Stage / TaskId）

- Scene：`filament-migration` / `bugfix` / `feature-admin` / `feature-api` / `cleanup` / `normal-dev`
- Stage：`context` / `execution` / `review` / `closeout`
- TaskId：有编号任务时显式提供；无编号任务时留空

默认优先引导用户提供这些参数；缺失时必须先输出最小追问或路由建议。

## repo-local controller（仓库内执行入口）

若项目采用脚本辅助工作流，脚本必须以 repo-local 形式存在，并以“轻量 wrapper → repo-local 脚本”的方式避免全局版本漂移。

可参考的 wrapper 示例在本 Kit：`project/assets/migrationctl-lite.ps1`。

## Task Record（任务记录）

当任务需要留痕（中/重任务，或用户明确要求记录过程）时，按固定模板输出任务记录（可作为独立 markdown 文件或直接内联在交付输出中）：

- 最小字段集：Scene / Pool(or module) / Role / Stage / Status
- 固定区块：Scope / Constraints / Execution Notes / Review Verdict / Closeout Summary

模板参考：`project/assets/task-doc-template.md`。
