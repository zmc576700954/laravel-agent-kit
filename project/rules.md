# Project Rules（仓库绑定的操作性约束）

本目录用于承载“与当前仓库工作方式强绑定”的规则与附属资产（脚本、模板、任务记录规范等）。它与 `global/` 的区别是：这里允许出现“仓库目录约定/任务文档位置/执行入口脚本”等操作性信息，但仍应保持可复用、可版本化、可直接 copy/symlink 安装。

## 优先级与叠加方式

1. Global Rules（`global/`）提供治理 Hard 约束与 Laravel Baseline 底线。
2. Project Rules（本目录）补齐“怎么在当前仓库里工作”的操作性规范。
3. Skills（`skills/`）只写场景差异与闭环剧本，不重复写 Global/Project 的通用段落。

## 显式参数优先（Scene / Stage / TaskId）

在具备工作流概念的任务中，优先使用显式参数而不是从自然语言强推断：

- Scene：`filament-migration` / `bugfix` / `feature-admin` / `feature-api` / `cleanup` / `normal-dev`
- Stage：`context` / `execution` / `review` / `closeout`
- TaskId：有编号任务时显式提供；无编号任务时留空

当用户没有给出这些参数时，Agent 必须先路由到合适的场景 Skill，并在输出中给出建议的 Scene/Stage（需要用户确认时必须停下）。

## repo-local controller（仓库内执行入口）

若项目采用脚本辅助工作流（例如迁移协作、任务记录、阶段性笔记），脚本必须以 repo-local 形式存在，并以“轻量 wrapper → repo-local 脚本”的方式避免全局版本漂移：

- wrapper：放在个人环境（或可复用工具目录），仅负责定位并调用仓库内脚本
- repo-local：放在仓库内固定路径（示例：`.codex/bin/`），由仓库版本控制

本 Kit 提供一个可参考的 wrapper 示例：`project/assets/migrationctl-lite.ps1`。

## Task Record（任务记录）

当任务需要留痕（中/重任务，或用户明确要求记录过程）时，使用统一的任务记录结构，以便可审计、可回放：

- 最小字段集：Scene / Pool(or module) / Role / Stage / Status
- 固定区块：Scope / Constraints / Execution Notes / Review Verdict / Closeout Summary

模板参考：`project/assets/task-doc-template.md`。
