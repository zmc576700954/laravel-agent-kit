# 场景 Skills 最小示例（Prompt + 期望输出片段）

目标：为每个 Skill 提供 1 个最小示例，能观察到“模块感知 Discovery + 闭环输出区块（Scope/Task Level/Plan/Implement/Verify）+ Stop Conditions”的生效信号。

## 安装（Trae / Qoder）

- Trae：复制 `dist/trae/skills/*` → 安装到 Trae 的 skills 目录
- Qoder：复制 `dist/qoder/.qoder/` → 项目根目录 `.qoder/`

## 1) api-endpoint（新增 API 接口）

**Prompt**
```text
请新增一个 POST /api/v1/projects 创建项目接口：
- 字段：name（必填，<=120），status（draft/active/archived，默认 draft）
- 权限：仅管理员可创建
- 返回：201 + JSON（包含 id/name/status）
约束：不新增依赖；不允许扩扫；必须补测试（Pest/PHPUnit 以项目为准）
```

**期望输出片段**
```text
Scope:
- In Scope: routes/api.php, app/Http/Controllers/**, app/Http/Requests/**, app/Policies/**, tests/**
- Out of Scope: 全量重构、任何整体迁移执行
- Expand Scope: No

Task Level: Heavy（原因：新增接口 + 鉴权 + 需要测试闭环）

Plan:
- Read: composer.json, routes/api.php, app/Providers/RouteServiceProvider.php(如存在), 现有同类 Controller/Request/Resource
- Change: route + controller + form request + policy/gate + resource + tests
- Risk & Rollback: 不改既有响应结构；如需变更契约先触发 Stop Conditions

Verify:
- php -l <changed-files>
- php artisan test（或 vendor/bin/pest）
```

## 2) change-existing（修改既有功能）

**Prompt**
```text
请在不改变既有成功响应结构的前提下，为 GET /api/v1/projects 增加可选过滤参数 status。
范围：仅允许改 routes/api.php、对应 Controller/Service/Query、以及测试；不允许扩扫。
```

**期望输出片段**
```text
Discovery: 先确定单体 vs 多模块，并在模块根内选择落点；不扩扫。
Plan: 先找现有 list 接口的过滤/分页约定，再做增量修改并补测试。
Stop Conditions: 如需改变分页/错误码语义或响应结构，先停下确认。
```

## 3) bug-triage（Bug 排查与定位）

**Prompt**
```text
线上偶发 500：POST /api/v1/projects 偶尔返回 “Undefined array key status”。
范围：只允许读写项目接口相关文件与测试；不允许扩扫。目标：先定位根因并给出最小修复方案。
```

**期望输出片段**
```text
Plan:
- Read: 触发点的 Controller/Request/Service + 相关测试 + 最近改动涉及的 DTO/Resource
- Repro: 用最小请求复现（或写一个最小测试复现）
- Narrow down: 把 “status” 的来源链路画清楚（request -> validated -> fill -> cast）
Verify: 复现用例通过 + 回归关键路径
```

## 4) bug-fix（代码修复与回归）

**Prompt**
```text
请修复：当 name 为空时接口没有返回 422，而是 500。
约束：不新增依赖；不允许扩扫；必须给出回归验证命令。
```

**期望输出片段**
```text
Implement: 先让 bug 可复现（测试/最小请求），再修复，再验证复现消失。
Verify: php artisan test（或 vendor/bin/pest）
```

## 5) migration-safe（迁移安全）

**Prompt**
```text
需要给 projects 表新增 status 字段并回填默认值 draft。
约束：不允许执行整体 migrate/rollback；只能给出单迁移文件方案与验证步骤。
```

**期望输出片段**
```text
Stop Conditions: 任何整体迁移命令、数据口径变更、线上回填策略不明确时先停下确认。
Verify:
- php artisan migrate --path=database/migrations/<file>.php（仅在授权后）
- 回滚命令与预期影响说明
```

## 6) performance-nplus1（性能 / N+1）

**Prompt**
```text
GET /api/v1/projects 列表很慢，怀疑 N+1。请给出定位与最小优化方案，并提供可验证的对比方式。
范围：只允许改该接口相关 Controller/Query/Resource；不允许扩扫。
```

**期望输出片段**
```text
Discovery: 确认 Resource/Transformer 是否触发关系访问；列出需要 eager load 的关系。
Verify: 对比优化前后查询次数/关键 SQL（以项目现有日志/调试方式为准）
```

## 7) testing-pest-phpunit（测试补齐）

**Prompt**
```text
请为 projects 创建接口补齐关键测试（成功/403/422 三类）。
约束：不新增依赖；测试框架以项目为准（Pest 或 PHPUnit）。
```

**期望输出片段**
```text
Discovery: 先识别 Pest vs PHPUnit（composer.json / tests 目录），选择最小改动风格补测试。
Verify: vendor/bin/pest 或 php artisan test
```

## 8) profile-filament-admin-migration（Profile：Filament Admin 迁移）

**Prompt**
```text
目标：把旧后台项目列表页迁移为 Filament Resource（只改 Admin，不动 API）。
Profile：启用 Filament Admin 迁移 Profile。
范围：仅允许修改 app/Filament/** 与必要的后台 Service；不允许扩扫。
```

**期望输出片段**
```text
Plan:
- Constraint: 涉及 app/Filament/** 时不使用 Filament\\Tables\\Actions\\*，统一用 Filament\\Actions\\*
Verify:
- php -l <changed-files>
- php artisan route:list --path=<keyword>
```

## 9) owl-admin-profile（Profile：OwlAdmin）

**Prompt**
```text
这是一个 OwlAdmin 存量项目，准备规划迁移到 Filament，但本次只需要先建立迁移边界与不变量。
Profile：启用 OwlAdmin Profile。
```

**期望输出片段**
```text
Hard: 默认不启用；启用后只约束迁移边界（不扩散到 API、不改数据库/权限真相源/接口契约）。
Stop Conditions: 任何迁移批次推进或写入热文档前先停下确认。
```

