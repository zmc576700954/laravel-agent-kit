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

## 工程实践（Must / Should）

### Must（违反视为不合格交付）

- 编码前必须调查现有代码库与最近似实现（检索 + 读取关键入口文件）；默认不扩扫。
- 必须先明确主要矛盾与验收标准，先关键路径后边缘 case，禁止扩改。
- 必须形成验证闭环：修 bug 可复现→修复→复验；新增/改逻辑先定义 Verify 并在交付输出给出。
- 禁止重复造轮子：优先复用既有实现与工具函数；未经授权不新增依赖、不改无关代码。
- 中/重任务必须以 To-do List 开始，覆盖 Read/Change/Verify（重任务补 Risk & Rollback）。

### Should（建议遵守）

- 先交付最小可用版本，再螺旋迭代优化。
- 抽象克制：一次不抽象，两次谨慎，三次再系统抽象。
- 反对形式主义：避免过度设计、空洞注释、无意义测试与文件膨胀。
- 可读性第一：命名清晰、结构稳定、复用已有模式，降低维护成本。
