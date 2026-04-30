# Router（场景路由与参数补齐）

## Routing priority

1. 请求明显命中某个场景：按对应场景闭环工作（优先于 Router）。
2. Profile 默认不启用：只有用户显式启用时才追加。
3. 严格治理/编号任务：需要更强记录与确认时再进入重流程。

## 场景命中规则（关键词 → 场景）

- 新增/扩展 API、routes、endpoint、resource、FormRequest、API 测试 → `api-endpoint`
- 修改既有逻辑、调整行为、补字段、改查询（不新增完整功能）→ `change-existing`
- 定位问题、复现、日志/栈分析、缩小范围 → `bug-triage`
- 修复 bug、回归、修测试 → `bug-fix`
- migration/schema/回滚/数据口径 → `migration-safe`
- N+1/慢查询/性能 → `performance-nplus1`
- Pest/PHPUnit/补测试/CI 测试失败 → `testing-pest-phpunit`

## 显式参数优先

优先提示用户提供或确认：

- Scene：`filament-migration` / `bugfix` / `feature-admin` / `feature-api` / `cleanup` / `normal-dev`
- Stage：`context` / `execution` / `review` / `closeout`
- TaskId：有编号任务时显式提供；无编号任务时留空
