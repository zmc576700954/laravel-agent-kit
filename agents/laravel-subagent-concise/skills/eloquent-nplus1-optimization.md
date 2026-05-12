# Skill: Eloquent N+1 Prevention & Optimization

## 目标 (Goal)
预防并在现有代码中修复 Eloquent N+1 查询性能瓶颈。AI 必须在编写和审查涉及数据库查询的代码时强制应用此规则。

## 触发条件 (Trigger)
当你在 Controller、Resource、Service 或 View 中读取 Eloquent Model 的关联数据（Relationship）且该操作处于循环中时，或者用户要求你进行“性能优化”时。

## 核心逻辑 (Implementation Logic)
1. **识别触发点**：扫描 `foreach` 循环或对 Collection 的遍历，检查是否存在形如 `$model->relation->property` 的调用。
2. **预加载策略 (Eager Loading)**：
   - 使用 `with('relation')` 在查询构造器层面进行预加载。
   - 如果数据已经查询出来，使用 `$collection->load('relation')` 进行懒惰预加载。
   - 仅仅需要关联数量时，使用 `withCount('relation')`。
   - 仅仅需要判断关联是否存在时，使用 `withExists('relation')`。
3. **闭环验证 (Verification)**：
   - 修改完成后，必须在 Verify 阶段建议用户使用 `DB::listen` 或 Laravel Debugbar 检查 SQL 查询条数，确保由 N+1 退化为 1-2 条高效查询。
