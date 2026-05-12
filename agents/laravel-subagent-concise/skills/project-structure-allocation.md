# Skill: Project Structure & Layer Allocation

## 目标 (Goal)
规范化 AI 在进行代码生成时的文件存放位置与层级分配。强制推行 Laravel 最佳实践，并在遇到不合理的架构反模式时拦截并向用户发出警告。

## 触发条件 (Trigger)
当需要生成新的类（Controller, Model, Request, Resource, Service, Action, DTO 等），并决定其存放目录时。

## 核心逻辑 (Implementation Logic)

### 1. 目录决断优先级 (Path Resolution Priority)
在确定任何文件的生成目录时，必须严格遵守以下优先级（由高到低）：

1. **[最高] 用户指定 (User Specified)**
   - 检查用户当前的对话指令是否明确给出了路径（如：“在 `app/Modules/User/` 下生成”）。
2. **[中等] 用户代码目录结构配置 (Project Configuration)**
   - 检索项目是否配置了全局规则（如 `AGENTS.md`, `CLAUDE.md`，或 `project/memory.md`）。
   - 如果项目本身是多模块（如使用 `nWidart/laravel-modules`，存放在 `Modules/` 目录），则必须遵循模块化目录约定，而非默认的 `app/` 目录。
3. **[基础] Laravel 默认代码目录结构 (Laravel Default Standard)**
   - 如果前两者皆未指定，采用 Laravel 官方与社区标准的目录结构：
     - Models: `app/Models/`
     - Controllers: `app/Http/Controllers/`
     - FormRequests: `app/Http/Requests/`
     - Resources: `app/Http/Resources/`
     - Services: `app/Services/` (用于跨模型复杂领域逻辑)
     - Actions: `app/Actions/` (遵循单一职责 SRP 的单方法类)
     - DTOs: `app/DTOs/` (数据传输对象)

### 2. 架构反模式与不合理结构排查 (Architecture Anti-Pattern Warning)
在读取已有代码以确认目录环境时，如果发现以下“不合理”的结构，**必须**暂停自动生成，并通过 Output Contract 提醒用户排查：

- **臃肿控制器 (Fat Controller)**：如果目标 Controller 包含了大量的业务计算、直接的 DB 事务或超过 300 行，提醒用户：*“当前 Controller 过于臃肿，不符合 Laravel 最佳实践，建议抽离至 Action 或 Service。”*
- **错位的业务逻辑**：如果发现用户试图让您在 `app/Http/Requests/` 或 `app/Http/Resources/` 中编写复杂的数据库写入逻辑，必须拦截，提示：*“请求与资源类不应包含核心写入逻辑，请重构至 Service 或 Controller。”*
- **目录碎片化**：在没有采用正式模块化包（Module）的情况下，强行在 `app/` 下建立了大量自定义目录且互相耦合。

### 3. Agent 执行要求 (Agent Execution)
- 规划阶段 (Planning)：必须在 `Plan` 输出中明确标出将要创建的文件的具体绝对路径。
- 如果触发了排查警告，将警告信息写入 `Exceptions/Risks` 区块，并询问用户是否继续或先重构。
