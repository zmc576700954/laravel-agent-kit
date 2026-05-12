# Skill: Safe Migrations & Rollback

## 目标 (Goal)
确保数据库 Schema 变更的安全、增量、可逆，避免破坏生产环境数据。

## 触发条件 (Trigger)
当用户要求修改数据库表结构、增加字段、修改类型或新建表时。

## 核心逻辑 (Implementation Logic)
1. **增量变更**：不要去修改历史已提交的 migration 文件，除非该项目处于极其早期的无数据阶段。通过新建 migration（如 `add_status_to_orders_table`）来增加或修改字段。
2. **可逆性 (Reversibility)**：
   - `up()` 方法中的所有 Schema 变更，必须在 `down()` 方法中提供完全对应的逆向操作（如 `dropColumn`）。
3. **定向执行 (Targeted Execution)**：
   - 在执行迁移验证时，严禁使用 `php artisan migrate:fresh` 或全局 `migrate`。
   - 必须调用 Agent 专属工具脚本：`.\agents\laravel-subagent-concise\tools\safe-migrate.ps1`。该脚本会自动寻找最新生成的迁移文件并追加 `--path` 参数进行安全执行。
4. **安全警告**：如果涉及到破坏性变更（如删除字段、重命名并丢失数据），必须在 Plan 阶段向用户发出明确警告。
