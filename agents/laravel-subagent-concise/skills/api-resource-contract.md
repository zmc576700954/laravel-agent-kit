# Skill: API Resource Output Contract

## 目标 (Goal)
通过 API Resource 层隔离数据库结构与客户端契约，建立防腐层。

## 触发条件 (Trigger)
当开发 API 接口并需要向客户端返回 Eloquent Model 或 Collection 数据时。

## 核心逻辑 (Implementation Logic)
1. **禁止直接暴露 Model**：绝不要在 Controller 中直接 `return $model;` 或 `return $model->toArray();`。
2. **结构映射**：
   - 必须调用 Agent 专属工具脚本：`.\agents\laravel-subagent-concise\tools\make-api-component.ps1 -Name {ModelName}` 来自动生成对应的 JsonResource 类（如 `UserResource`）。
   - 在 `toArray()` 方法中显式定义返回的字段。
3. **条件关联加载防泄漏**：
   - 当需要输出关联模型数据时，必须使用 `$this->whenLoaded('relation')`。
   - 这能防止在未预加载时意外触发 N+1 查询，保证性能底线。
