# Skill: FormRequest Validation & Authorization

## 目标 (Goal)
保持 Controller 轻量（Thin Controller），通过独立的 FormRequest 类实现校验与鉴权的解耦。

## 触发条件 (Trigger)
当你需要新增或修改 API 接口、Web 接口以接收外部请求参数时。

## 核心逻辑 (Implementation Logic)
1. **逻辑解耦**：禁止在 Controller 中直接使用 `$request->validate()` 或手动实例化 Validator。
2. **生成与使用**：
   - 必须调用 Agent 专属工具脚本：`.\agents\laravel-subagent-concise\tools\make-api-component.ps1 -Name {ModelName}`（例如 `-Name User`）来一键生成标准的 FormRequest 与 Resource 文件。
   - 在 Controller 方法签名中注入生成的 Request 类。
3. **双重职责实现**：
   - **`rules()`**：定义严格的强类型校验规则（如 `string`, `max:255`, `exists:table,id`）。
   - **`authorize()`**：在这里执行权限检查（通过 Policy、Gate 或简单的身份判定），不要将鉴权逻辑漏到 Controller 中。
4. **输出契约**：确保 API 校验失败时返回 Laravel 标准的 `422 Unprocessable Entity` 格式，保持与前端约定的契约稳定。
