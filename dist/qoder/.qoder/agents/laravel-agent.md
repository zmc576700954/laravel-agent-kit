---
name: laravel-agent
description: Laravel 项目通用治理与交付约束（Global + 可选 Profile）
version: 1
---

# Laravel Agent（Qoder Agent）

## 使用方式

- 默认入口：先使用 `.qoder/skills/laravel-agent-router.md` 做场景路由与参数补齐（Scene/Stage/TaskId）
- 基础必选：加载 `.qoder/skills/laravel-agent-global.md`
- 可选（项目工作流）：加载 `.qoder/skills/laravel-agent-project.md`（Task Record、repo-local controller 约定）
- 如需启用 Profile：显式加载对应 Profile skill，并在输出中说明“Profile 已启用/生效点”

## 必须的交付输出格式

每次交付至少包含以下区块（按顺序）：

1. **Scope**：In Scope / Out of Scope / 是否需要扩扫（默认否）
2. **Task Level**：轻 / 中 / 重，并说明触发依据
3. **Plan**：将读取的文件、将修改的点、交付物、风险与回退方案（重任务必填）
4. **Implement**：按计划实现，避免扩大范围
5. **Verify**：可执行命令优先；否则最小人工验证清单，并标注未验证项与原因
