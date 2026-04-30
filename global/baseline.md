# Community Baseline（Laravel 技术约定与质量底线）

本 Baseline 作为 Laravel 相关任务的“技术质量底线”。它不包含项目治理（范围控制、任务分级、迁移执行策略等），治理类硬约束由 `global/reality-layer.md` 提供。

## 来源（可溯源）

- Laravel Docs：AI Assisted Development https://laravel.com/docs/12.x/ai
- Laravel Docs：Laravel Boost https://laravel.com/docs/12.x/boost
- Laravel Blog：AI Coding Tips for Laravel Developers https://blog.laravel.com/ai-coding-tips-for-laravel-developers
- GitHub Docs：Copilot agent best practices https://docs.github.com/en/copilot/how-tos/agents/copilot-coding-agent/best-practices-for-using-copilot-to-work-on-tasks
- GitHub Blog：How to write a great agents.md https://github.blog/ai-and-ml/github-copilot/how-to-write-a-great-agents-md-lessons-from-over-2500-repositories/
- 社区实践（可选）：Laraveldaily AI Guidelines https://laraveldaily.com/post/my-cursor-rules-for-laravel

## Baseline 规则清单（归纳）

### A. 工作流与输出契约

- 先探测 → 再方案 → 再改动 → 再验证
- 输出必须包含：变更摘要、影响文件、关键决策、验证命令（或最小验证清单）

### B. 依赖、边界与安全

- 不新增依赖（除非明确授权）
- 不假设库存在（以 `composer.json` 与代码证据为准）
- 不泄露敏感信息（禁止索要或复述密钥、凭据、隐私字段）

### C. Laravel 默认工程约定（可覆盖）

- Controller 保持薄；校验优先 Form Request；鉴权优先 Policy/Gate/中间件
- API 输出优先 Resource（或项目既有封装）
- ORM 优先 Eloquent；默认考虑规避 N+1（eager loading）
- 数据库变更必须走 migration（包含回滚、索引、约束）

### D. 验证与质量

- 新功能默认补测试（以项目实际使用 Pest/PHPUnit 为准）
- 交付包含格式化/静态分析（若项目存在 Pint/PHPStan/Psalm/PHPCS 等）

