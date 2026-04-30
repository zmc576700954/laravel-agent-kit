# Skills Index

本索引用于帮助在“按场景拆分”的 Skills 中快速选型。默认只启用 Global；场景 Skills 按需安装/启用；Profile Skills 默认不启用。

## Router / Fallback

- `laravel-agent-router`：默认入口与兜底路由。只负责识别场景并让位给专用 Skill；不覆盖专用 Skill 的规则。

## Scenarios（MVP）

- `laravel-agent-scenario-api-endpoint`：新增/扩展 API 接口（routes/controller/request/auth/resource/tests）
- `laravel-agent-scenario-change-existing`：修改既有功能（保持契约与边界稳定，最小改动）
- `laravel-agent-scenario-bug-triage`：Bug 排查（复现→证据→缩小→定位）
- `laravel-agent-scenario-bug-fix`：Bug 修复（最小修复→回归→风险说明）
- `laravel-agent-scenario-migration-safe`：迁移安全（单迁移执行、回滚、证据记录）
- `laravel-agent-scenario-performance-nplus1`：性能与 N+1（证据→优化→验证）
- `laravel-agent-scenario-testing-pest-phpunit`：测试补齐（验收→可执行测试→回归）

## Profiles（默认不启用）

- `laravel-agent-profile-filament-admin-migration`：Filament Admin 迁移协作与不变量（热文档/编号任务/约束）
- `laravel-agent-profile-owl-admin-profile`：OwlAdmin 占位 Profile
