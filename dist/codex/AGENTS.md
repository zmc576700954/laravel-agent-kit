# Laravel Agent Rules（Codex）

本文件用于约束你在 Laravel 项目中的工作方式与交付格式。必须严格遵守 Hard 约束；Profile 默认不启用，只有在用户明确启用或满足启用条件时才应用。


## 规则优先级

1. Hard（治理/安全/可控性）
2. Profile（项目/场景特有规则，默认不启用）
3. Community Baseline（Laravel 技术约定与质量底线）

## 必须的交付输出格式

每次交付至少包含以下区块（按顺序）：

1. **Scope**：In Scope / Out of Scope / 是否需要扩扫（默认否）
2. **Task Level**：轻 / 中 / 重，并说明触发依据
3. **Plan**：将读取的文件、将修改的点、交付物、风险与回退方案（重任务必填）
4. **Implement**：按计划实现，避免扩大范围
5. **Verify**：可执行命令优先；否则最小人工验证清单，并标注未验证项与原因

## Hard：Project Reality Layer（通用治理层）

### 范围控制与最小改动

- 不扫描整个项目。
- 只处理用户明确指定的文件、目录或任务范围。
- 默认不扩扫：仅在完成任务所必需时，才补读少量同类参考文件。
- 最小改动优先：外科手术式补丁修正；禁止顺手重构、批量清理、抽象升级、目录搬迁或扩大边界。
- 不确定就停止说明：范围、真相源、权限边界、迁移状态不清楚时，先指出阻断点再行动。

### 任务分级治理（轻 / 中 / 重）

- 轻任务：单文件/少量文件、无迁移、无跨边界、高风险项不触发
- 中任务：多文件或需要验证/结论沉淀
- 重任务：迁移/权限/接口契约/用户可见行为/跨模块/中文编码高风险；必须写清范围、风险、验证与回退方案

### Stop Conditions（触发必须先停下追问确认）

- 涉及数据库迁移执行或回滚策略变更（尤其是整体 migrate/rollback/fresh/refresh/reset）
- 涉及鉴权模型、权限边界或敏感数据处理策略变化（含 Policy/Gate/中间件/角色权限表）
- 涉及接口契约变更：路由、请求字段、响应结构、错误码、分页/过滤语义、Web/API 可见行为
- 涉及中文正文文件/热文档的写入或批量改动（编码、BOM、换行、内容一致性风险）
- 需要新增 Composer 依赖或升级关键依赖版本
- 涉及生产配置、密钥、第三方凭据、支付/风控等高风险域

### 数据库迁移安全

- 未经明确授权，禁止执行整体迁移或整体回滚（如 `php artisan migrate`、`migrate:fresh`、`migrate:refresh`、`migrate:reset`、批量 rollback）。
- 新增迁移文件后，默认只允许按“单个迁移文件”定向执行：`php artisan migrate --path=database/migrations/<filename>.php`。
- 执行前必须记录：迁移文件名、完整命令、执行原因、预期影响、回退方案；执行后立即记录结果与异常信息。

### 中文编码与乱码防护

- 修改现有文件前先确认原始编码、BOM、换行风格；默认保持不变。
- 禁止使用未显式声明编码的方式覆盖中文正文文件（如 shell 内联正文、`echo/>>`、重定向整文件覆盖、PowerShell here-string、`Set-Content`、`Out-File`）。
- 写入后立即复检：标题、首段、一段中文正文、末段、文件尾；发现乱码（`�`、批量 `?`、异常 BOM、`\uXXXX` 残留、换行漂移）必须先恢复再继续。

### 验证闭环

- 修 Bug：先复现→修复→验证复现消失。
- 加逻辑：先定义最小验证动作（测试/对比/检查/示例运行）再实现。
- 交付必须给出可执行验证命令；无法运行时必须说明命令、失败原因与影响范围。

## Community Baseline（技术约定与质量底线）

- 不新增依赖（除非明确授权）；不假设库存在（以 `composer.json` 与代码证据为准）。
- 不泄露敏感信息（禁止索要或复述密钥、凭据、隐私字段）。
- Controller 保持薄；校验优先 Form Request；鉴权优先 Policy/Gate/中间件。
- API 输出优先 Resource（或项目既有封装）；默认考虑规避 N+1（eager loading）。
- 数据库变更必须走 migration（包含回滚、索引、约束）。
- 新功能默认补测试（Pest/PHPUnit 以项目为准）；交付包含格式化/静态分析（若项目存在 Pint/PHPStan/Psalm/PHPCS 等）。

## Project Rules（可选，推荐在有工作流时启用）

### 显式参数优先（Scene / Stage / TaskId）

- Scene：`filament-migration` / `bugfix` / `feature-admin` / `feature-api` / `cleanup` / `normal-dev`
- Stage：`context` / `execution` / `review` / `closeout`
- TaskId：有编号任务时显式提供；无编号任务时留空

### repo-local controller（仓库内执行入口）

若项目采用脚本辅助工作流，脚本必须以 repo-local 形式存在，并以“轻量 wrapper → repo-local 脚本”的方式避免全局版本漂移。

本 Kit 在 `dist/project-assets/` 提供可参考资产：

- `migrationctl-lite.ps1`
- `task-doc-template.md`

## Router / 场景闭环（手工路由）

本入口为单文件规则，不假设存在 skills 体系。需要按“场景闭环”工作时，按下列口径手工路由，并以对应闭环输出（Scope/Task Level/Plan/Implement/Verify）交付：

- 新增/扩展 API、routes、endpoint、resource、FormRequest、API 测试 → 场景：`api-endpoint`
- 修改既有逻辑、调整行为、补字段、改查询（不新增完整功能）→ 场景：`change-existing`
- 定位问题、复现、日志/栈分析、缩小范围 → 场景：`bug-triage`
- 修复 bug、回归、修测试 → 场景：`bug-fix`
- migration/schema/回滚/数据口径 → 场景：`migration-safe`
- N+1/慢查询/性能 → 场景：`performance-nplus1`
- Pest/PHPUnit/补测试/CI 测试失败 → 场景：`testing-pest-phpunit`

优先引导用户显式给出或确认（缺失则先追问再改动）：

- Scene：`filament-migration` / `bugfix` / `feature-admin` / `feature-api` / `cleanup` / `normal-dev`
- Stage：`context` / `execution` / `review` / `closeout`
- TaskId：有编号任务时显式提供；无编号任务时留空

## Profiles（默认不启用）

如用户明确启用 Profile（例如 “启用 Filament Admin 迁移 Profile”），则在不违反 Hard 规则的前提下追加该 Profile 的约束，并在输出中说明“Profile 已启用/生效点”。
