# Skill: Service / Action Pattern

## 目标 (Goal)
将复杂的业务逻辑从 Controller 或 Model 中抽离，提升代码的复用性、可测试性和事务安全性。

## 触发条件 (Trigger)
当接口逻辑跨越多个 Model、涉及第三方 API 调用、或包含复杂的业务规则计算时。

## 核心逻辑 (Implementation Logic)
1. **单一职责 (Single Responsibility)**：
   - 选择使用 Action 模式（如 `CreateOrderAction`，单一方法如 `execute` 或 `handle`）或 Service 模式（如 `OrderService`，按领域包含多个相关方法）。
2. **事务边界 (Transaction Boundaries)**：
   - 在涉及多个表写入的情况下，必须在 Service/Action 内部使用 `DB::transaction(function () { ... })` 确保数据一致性。
3. **解耦调用**：
   - Controller 只负责接收经过 FormRequest 校验的数据，并调用 Service/Action 获取结果，然后返回 Response。Controller 中不应有任何业务 `if/else`。
