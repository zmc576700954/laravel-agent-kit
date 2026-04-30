# Prompt 生成器规则（Laravel）

## 目标

将用户自然语言需求转换为可执行、可验证、低歧义的 Laravel 任务 Prompt，并保证包含必要上下文与硬约束。

## 规则分层（必须体现）

生成器输出必须明确标注三类规则输入，并按优先级合并到 Prompt：

1. **Community Baseline（Laravel 技术约定）**：Controller/Request/Policy/Resource/Migration/Test 等通用实践（见 `global/baseline.md`）
2. **Project Reality Layer（通用治理能力）**：范围控制、任务分级、迁移安全、中文编码防护、验证闭环（见 `global/reality-layer.md`）
3. **Project Rules（仓库操作性规则）**：显式参数（Scene/Stage/TaskId）、repo-local controller、Task Record 等（见 `project/rules.md`）
4. **Profile（项目特有规则）**：如 Filament 迁移协作协议、目录不变量、热文档串行写规则（见 `profiles/*.md`）

## 生成步骤（必须）

1. 识别任务类型：Feature / Bugfix / Refactor / Performance / Explain
2. 产出范围控制：In Scope / Out of Scope / 是否允许扩扫（默认 否）
3. 任务分级：轻/中/重，并说明触发依据（迁移/权限/API 契约/跨模块/中文文件等）
4. 触发最小项目探测：列出将读取的文件与要确认的版本/工具链点
5. 识别是否需要启用 Profile：默认不启用；仅在用户明确指定或触发条件满足时启用
6. 补全模板字段：对缺失字段做追问或给出默认值（需明确标注默认）
7. 生成“计划块（Plan）”：文件读取计划、改动点、交付物、回退方案（重任务必填）
8. 生成“约束块”：baseline + reality layer + profile（按 Hard/Soft/Profile 标注）
9. 生成“验收块”：至少 3 条 WHEN/THEN
10. 生成“验证块（Verify）”：可执行命令优先；否则提供最小验证清单与证据来源

## 字段缺失处理（校验规则）

- 缺少 **Goal**：拒绝继续生成代码，必须追问目标
- 缺少 **Scope**：先给出建议 scope，并要求用户确认
- 缺少 **Constraints**：默认启用“不新增依赖”“不改公共 API”“遵循现有工具链”
- 缺少 **Acceptance Criteria**：Agent 必须主动补 3 条，并标注为“建议验收”
- 缺少 **Verification**：Agent 必须给出可执行命令，或提供最小验证清单

## 何时必须停下追问（Stop Conditions）

- 需要新增 Composer 依赖
- 涉及鉴权模型、权限边界或敏感数据处理策略变化
- 涉及接口契约变更：路由、请求字段、响应结构、错误码、分页/过滤语义、Web/API 可见行为
- 涉及生产配置、密钥、第三方凭据、支付/风控等高风险域
- 需要大规模架构调整（目录结构迁移、领域拆分、事件风暴式改造）
- 涉及数据库迁移执行或回滚策略变更（尤其是整体 migrate/rollback）
- 涉及中文正文文件/热文档的写入或批量改动（编码、BOM、换行、内容一致性风险）
- 涉及热文档写入权限、迁移任务号推进或真相源不明确

## 输出模板（生成器输出应长这样）

1. Task Type:
2. Scope (In/Out/Expand):
3. Task Level (Light/Medium/Heavy):
4. Discovery Plan:
5. Plan (Implementation Steps / Rollback):
6. Prompt（按对应模板字段）：
7. Constraints（Baseline / Reality Layer / Profile）:
8. Hard Constraints:
9. Definition of Done:
10. Verification Commands:
