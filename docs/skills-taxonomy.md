# Laravel 场景 Skill Taxonomy（MVP）

目标：用“开发者高频行为”而非目录层级（Controller/Service/Model）来组织技能，使每个 Skill 覆盖一个完整闭环：探测 → 设计落点 → 实现 → 关联项 → 验证 → 交付输出。

## 1) 场景分组（Taxonomy）

### A. 新增 / 修改（Build / Change）
- **新增 API / HTTP 能力**：新增路由、请求校验、鉴权、资源输出、测试
- **修改既有功能**：在已有模块与既有风格内做增量修改，避免行为漂移
- （扩展）新增后台页面（Filament/OwlAdmin）、新增队列任务、增加事件监听

### B. 排查 / 修复（Diagnose / Fix）
- **Bug 排查与定位**：复现 → 收集证据 → 缩小范围 → 定位根因
- **Bug 修复与回归**：最小修复 → 回归覆盖 → 交付验证与风险说明
- （扩展）线上事故快速止血、日志/可观测性增强

### C. 结构与数据安全（Structure / Data Safety）
- **数据库迁移与数据口径**：迁移策略、回滚路径、数据一致性与口径边界
- （扩展）权限模型变更、接口契约演进、配置/密钥治理

### D. 性能 / 可扩展性（Performance / Scalability）
- **性能排查与 N+1**：定位慢点、确认 SQL/关系加载、提供可验证优化
- （扩展）缓存策略、队列吞吐、索引与查询优化、并发与锁

### E. 测试 / 发布（Testing / Release）
- **测试补齐（Pest/PHPUnit）**：定义验收 → 先写/补关键测试 → 让验证可执行
- （扩展）CI 失败排查、静态分析、代码格式化与门禁

## 2) MVP Skills（6–8 个）

本仓库的 MVP 场景 Skill 集合选定为 7 个（对应 spec 列的全部 7 项）：

1. `api-endpoint`：新增 API 接口
2. `change-existing`：修改既有功能
3. `bug-triage`：Bug 排查与定位
4. `bug-fix`：代码修复与回归
5. `migration-safe`：数据库迁移与数据口径
6. `performance-nplus1`：性能排查与 N+1
7. `testing-pest-phpunit`：测试补齐（Pest/PHPUnit）

说明：
- Profile 类 Skill（如 Filament/OwlAdmin）不计入 MVP 场景数量，默认不启用，按需启用。
- 后续扩展建议：authz-policy、queue-job、cache-strategy、release-hotfix、security-sensitive。

