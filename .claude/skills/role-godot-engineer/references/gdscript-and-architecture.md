# GDScript & Architecture

## Static typing
Type everything. Static typing catches errors at parse time, speeds execution, and powers editor completion.
```gdscript
var speed: float = 300.0
@onready var sprite: Sprite2D = $Sprite2D
func take_damage(amount: int) -> void: ...
signal health_changed(current: int, max: int)   # typed signal
```
- Type variables, function params, returns, and signal args.
- Prefer enums over magic strings/ints for states and kinds.
- Use `class_name` for reusable types; `const` for fixed values.

## Node access — cache, don't look up
- Cache once with `@onready`; never call `get_node()` / `$Path` inside `_process()` or loops.
- Reference children, signal to parents. Avoid `get_parent().get_parent()...` chains — that is coupling debt.

## Signals & event bus ("signal up, call down")
- A node may *call down* into its own children, but should *signal up* to whoever owns it. This keeps children reusable and ignorant of their context.
- For cross-branch communication (unrelated systems), use a typed **event-bus autoload** rather than direct references:
```gdscript
# EventBus.gd (autoload)
signal enemy_died(enemy: Node, xp: int)
signal level_completed(level_id: StringName)
```
- Connect with typed callables; disconnect when nodes leave to avoid dangling connections.
- Symptom to flag: systems reaching across the tree by absolute path. Replace with signals/event-bus.

## Scene & node composition
- Compose behavior from small, single-responsibility scenes/nodes rather than deep inheritance.
- Descriptive node names; group related nodes; use `groups` for "all enemies"-style queries.
- A scene should own a coherent slice of behavior and expose a small surface (exported vars + signals).

## Data vs logic — Resources
- Put **data** in custom `Resource` types (`.tres`): stats, configs, item defs, tuning tables.
- Put **logic** in scripts. Never bury game logic inside a Resource.
```gdscript
class_name EnemyStats extends Resource
@export var max_hp: int = 100
@export var move_speed: float = 200.0
```
- Resources make data designer-editable, diffable, and reusable across scenes.

## Component systems
- Model reusable capabilities as component nodes: `HealthComponent`, `HitboxComponent`, `HurtboxComponent`.
- Components communicate by signals; the host scene wires them. This beats monolithic actor scripts.

## State machines
- Implement FSMs with dedicated `State` nodes (enter/exit/update) or an enum-driven machine for simple cases.
- One source of truth for current state; transitions are explicit, not scattered booleans.

## Autoloads (singletons) — sparingly
- Reserve autoloads for *truly global* systems: `GameManager`, `SaveManager`, `EventBus`.
- Set `process_mode = Node.PROCESS_MODE_ALWAYS` on managers that must run during pause.
- Do not use autoloads as a dumping ground for state that belongs to a scene.
