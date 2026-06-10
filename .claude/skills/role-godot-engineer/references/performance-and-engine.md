# Performance & Engine

Measure before optimizing — use the Godot **profiler** (and the network/monitors tabs) to find real hotspots. Most engine perf wins are in `_process`/`_physics_process` and allocation churn.

## Process loops
- Cache node references with `@onready`; never `get_node()` / `$Path` inside `_process()` or loops.
- Disable processing when not needed: `set_process(false)`, `set_physics_process(false)`; re-enable on demand.
- Keep `_process` doing frame-rate-dependent work and `_physics_process` doing fixed-step physics; don't put physics in `_process`.
- Prefer signals/timers over polling state every frame.

## Allocations & memory
- Object-pool frequently spawned entities (bullets, enemies, VFX) instead of instancing/freeing per shot.
- Reuse arrays/dictionaries rather than allocating new collections each frame.
- Free nodes with `queue_free()` (deferred, safe), not `free()` mid-frame.
- Watch for leaked signal connections and references that keep nodes alive.

## Physics
- Use the right body type: `StaticBody`, `RigidBody`, `CharacterBody`, `Area` for detection.
- Tune collision layers/masks so bodies only test against what matters.
- Batch raycasts; avoid per-frame raycasting from many nodes when an `Area` query suffices.

## Multithreading
- Offload heavy non-scene work (pathfinding bake, procedural gen, IO) to `WorkerThreadPool` or threads.
- The scene tree is not thread-safe: marshal results back to the main thread (`call_deferred`) before touching nodes.

## Rendering & visuals
- Shaders: prefer built-in `CanvasItem`/`Spatial` shaders; keep fragment work cheap; avoid branching in hot shaders.
- Use `GPUParticles` for large particle counts; reserve `CPUParticles` for compatibility/small counts.
- 3D: mind draw calls, LOD, occlusion, and light/shadow counts; bake where possible.

## Multiplayer
- RPCs over ENet (or WebSocket); annotate with `@rpc` and the correct authority/transfer mode.
- Use `MultiplayerSynchronizer`/`MultiplayerSpawner` for state sync; interpolate remote state, reconcile authoritative state.
- For dedicated servers, run headless (`--headless`) and keep server logic free of rendering assumptions.

## Native (GDExtension)
- Reach for GDExtension (godot-cpp, or Rust via gdext) only for genuine hot paths or native library bindings — not as a default.
- Keep the script/engine boundary small and typed; profile to prove the native path actually wins.

## Export & optimization
- Validate export presets per platform; strip debug, set release templates.
- Profile on the *target* device (especially mobile) — desktop framerate hides mobile bottlenecks.
