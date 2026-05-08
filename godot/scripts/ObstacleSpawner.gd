extends Node

const OBSTACLE_SCENE := preload("res://scenes/Obstacle.tscn")

var rng := RandomNumberGenerator.new()
var active: Array[Node2D] = []
var pool: Array[Node2D] = []
var spawn_timer := 0.0
var base_gap := 440.0
var base_speed := 360.0

func _ready() -> void:
rng.randomize()
for i in 6:
var obstacle := OBSTACLE_SCENE.instantiate()
obstacle.visible = false
pool.append(obstacle)
add_child(obstacle)

func reset_state() -> void:
spawn_timer = 0.0
for obstacle in active:
obstacle.visible = false
pool.append(obstacle)
active.clear()

func process_spawning(delta: float, difficulty: float, on_passed: Callable, on_player_hit: Callable) -> void:
spawn_timer -= delta
if spawn_timer <= 0.0:
_spawn_obstacle(difficulty, on_passed, on_player_hit)
spawn_timer = max(0.65, 1.2 - difficulty * 0.06)
_recycle_obstacles()

func _spawn_obstacle(difficulty: float, on_passed: Callable, on_player_hit: Callable) -> void:
if pool.is_empty():
return
var obstacle = pool.pop_back()
active.append(obstacle)
obstacle.visible = true
obstacle.position = Vector2(1220.0, 0.0)
var gap_size := clamp(base_gap - difficulty * 12.0, 230.0, 440.0)
var speed := base_speed + difficulty * 20.0
var center_y := rng.randf_range(460.0, 1460.0)
obstacle.configure(center_y, gap_size, speed)
if not obstacle.passed.is_connected(on_passed):
obstacle.passed.connect(on_passed)
if not obstacle.hit_player.is_connected(on_player_hit):
obstacle.hit_player.connect(on_player_hit)

func _recycle_obstacles() -> void:
for i in range(active.size() - 1, -1, -1):
var obstacle = active[i]
if obstacle.recycled:
active.remove_at(i)
obstacle.visible = false
pool.append(obstacle)
