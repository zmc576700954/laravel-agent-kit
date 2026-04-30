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

## 工程实践（Must / Should）

本节用于约束 AI 代码生成与日常开发行为，强调“基于事实”“抓主矛盾”“验证闭环”“复用优先”。按严谨程度分为 Must（强制）与 Should（建议）。

### Must（违反视为不合格交付）

1. 调查优先（不做调查不写实现）
   - 编码前必须调查现有代码库与最近似实现：最少完成一次检索（grep/搜索）并读取关键入口文件（route/controller/service/model/test 等）。
   - 若用户给了明确文件/目录范围，只在该范围内调查；默认不扩扫。

2. 主要矛盾优先（先关键路径后边缘）
   - 接到任务必须先明确：核心问题、验收标准、关键路径、不可改动边界（契约/权限/数据口径）。
   - 先解决主要矛盾，再处理次要矛盾与边缘 case；禁止“全线出击”式扩改。

3. 验证闭环（实践检验）
   - 修 Bug：必须“可复现 → 修复 → 验证复现消失”。
   - 新增/改逻辑：必须先定义最小可验证动作（测试/命令/人工验证清单），交付必须包含 Verify。

4. 禁止重复造轮子（复用优先）
   - 实现新功能前必须检索是否已有同类实现、工具函数或组件，优先复用项目既有模式与封装。
   - 未经授权不新增依赖、不引入无关抽象、不改无关代码。

5. 任务以 To-do List 开始
   - 中/重任务必须先列出步骤清单（To-do），再进入实现；步骤需覆盖 Read/Change/Verify（重任务还需 Risk & Rollback）。

### Should（建议遵守，不作为硬性失败条件）

1. 迭代优先：先交付可用的最小版本，再螺旋迭代优化；不追求一步到位。
2. 抽象克制：一次使用不抽象，两次谨慎考虑，三次再系统抽象。
3. 反对形式主义：避免过度设计、无意义测试、空洞注释、文件膨胀（可拆分时及时拆分）。
4. 可读性第一：命名清晰、结构稳定、复用已有模式，减少维护成本。
