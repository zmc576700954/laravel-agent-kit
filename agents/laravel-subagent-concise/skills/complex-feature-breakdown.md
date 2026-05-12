# Skill: Complex Feature Breakdown & Architecture Decision

## 目标 (Goal)
当面对复杂业务需求时，防止 AI Agent 陷入“全盘硬编码”或“上下文超载”的困境。强制 AI 停止直接编码，转而通过结构化的提问引导用户进行架构决策（如：同步/异步、事件解耦、状态机），并产出/维护一份逐步完善的《复杂功能拆分文档》。

## 触发条件 (Trigger)
当满足以下任意条件时，必须立即进入本 Skill 流程：
1. 用户明确提到“功能繁琐”、“逻辑复杂”、“需要考虑性能”或“需要拆分”。
2. 需求描述中涉及多步长流程（如：支付成功后的回调处理、复杂的订单状态流转、大批量数据导入/导出）。
3. 需求涉及潜在的耗时操作（发送大量邮件/通知、请求多个外部第三方 API）。
4. Agent 在初步评估时发现，在一个 Controller 或 Service 中需要编写超过 100 行以上的业务逻辑才能满足需求。

## 核心逻辑 (Implementation Logic)

### Step 1: 拦截编码与初步梳理 (Halt & Analyze)
- **绝对禁止**：在未明确架构方案前，严禁直接生成核心业务代码。
- **动作**：梳理用户需求中的“主流程”与“副作用（附属流程）”，识别出潜在的性能瓶颈。

### Step 2: 引导架构决策 (AskUserQuestion)
通过 AskUserQuestion 工具或直接回复，向用户提出具体的架构选择。你需要基于 Laravel 最佳实践，提供合理的选项。

**常见提问维度示例：**
1. **耗时操作处理 (Sync vs Async)**：
   * *“发现该功能包含耗时的外部请求/邮件发送。如果失败是否需要回滚主流程？如果不需要，我建议使用 **队列 (Queues)** 异步处理。”*
2. **副作用解耦 (Monolithic vs Events)**：
   * *“主任务完成后需要触发多项不相关的操作。我们是使用一个庞大的 **Action 类** 顺序执行，还是采用 **Events & Listeners** 进行解耦？”*
3. **复杂状态流转 (State Machines)**：
   * *“发现实体存在多达 4 种以上的状态流转。您倾向于使用简单的 `if/switch` 判断，还是引入 **状态机 (State Pattern / spatie/laravel-model-states)** 来规范约束？”*

### Step 3: 生成/更新功能拆分文档 (Document Generation)
在与用户确认架构决策且业务逻辑通顺后：
1. 检查项目根目录或指定目录下是否存在任务说明文档（如 `docs/features/xxx-spec.md`）。
2. 如果不存在，使用提供的模板（如 `tools/feature-spec-template.md`）创建一个新文档。
3. 将确定的架构方案、拆分的子任务（Action, Job, Event, Listener）、数据表变更计划写入文档。
4. **作用**：这份文档将作为后续开发的 Single Source of Truth，防止因对话过长导致 Agent 遗忘上下文。

### Step 4: 切换至按步执行模式 (Step-by-Step Execution)
- 文档确认无误后，Agent 根据文档中的子任务清单，一次只挑选一个极小粒度的任务（如：只创建 Migration，或只编写 Event/Listener 类）进行开发。
- 每完成一个子任务，更新文档中的状态（如 `[ ]` 变为 `[x]`），并再次向用户确认是否继续下一个任务。