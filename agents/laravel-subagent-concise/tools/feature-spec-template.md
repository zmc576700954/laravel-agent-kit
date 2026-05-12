# 复杂功能拆分与架构设计文档 (Feature Spec)

## 1. 业务目标 (Goal)
*用一两句话描述该功能的核心目标，例如：实现一个支持分期付款的复杂支付回调处理流程。*

## 2. 架构决策记录 (Architecture Decisions)
*记录 AI 与用户讨论后确认的架构选型。*
- **主流程处理**: [如：使用 ProcessPaymentCallbackAction 同步处理]
- **副作用/耗时操作处理**: [如：使用 Events 触发邮件发送，Listener 放入 Queue 异步执行]
- **状态管理**: [如：使用简单的 Status Enum，或引入 State Machine 扩展包]

## 3. 核心数据结构变更 (Database Schema)
*记录需要新增的表、修改的字段。*
- [ ] 迁移文件: `add_installment_fields_to_orders_table`
- [ ] 迁移文件: `create_payment_logs_table`

## 4. 任务拆分与执行清单 (Task Breakdown)
*将大功能拆分为原子化的可执行子任务，Agent 将严格按照此清单逐一开发，每完成一项打钩。*

### Phase 1: 基础设施 (Infrastructure)
- [ ] 创建所需的数据迁移文件 (Migration)
- [ ] 更新 Eloquent Model (Casts, Relations, Enums)

### Phase 2: 核心业务逻辑 (Core Domain)
- [ ] 创建 FormRequest 进行数据校验
- [ ] 创建核心 Action / Service 类 (如 `ProcessPaymentAction`)
- [ ] 编写核心流程的单元测试 / 最小验证脚本

### Phase 3: 副作用与解耦 (Side Effects & Decoupling)
- [ ] 创建 Event 类 (如 `PaymentCompleted`)
- [ ] 创建 Listener 类并实现 `ShouldQueue` (如 `SendInvoiceEmail`)
- [ ] 在核心 Action 中触发 Event

### Phase 4: API 契约与对接 (API & Contract)
- [ ] 创建 API Resource 规范输出格式
- [ ] 创建 / 更新 Controller 协调调用
- [ ] 更新 routes 文件

## 5. 遗留风险与异常处理 (Risks & Exceptions)
*记录可能出现的边缘情况，如第三方 API 宕机时的重试机制、数据不一致时的补偿方案等。*
