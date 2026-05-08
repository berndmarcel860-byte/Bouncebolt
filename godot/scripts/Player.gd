extends CharacterBody2D

signal died

const GRAVITY := 2400.0
const BOUNCE_FORCE := -860.0
const MAX_DROP_SPEED := 1400.0

var alive := true

func _physics_process(delta: float) -> void:
if not alive:
return
velocity.y = min(MAX_DROP_SPEED, velocity.y + GRAVITY * delta)
move_and_slide()
if is_on_wall() or is_on_ceiling() or is_on_floor():
_die()

func bounce() -> void:
if alive:
velocity.y = BOUNCE_FORCE

func _die() -> void:
if not alive:
return
alive = false
emit_signal("died")

func reset_player(position_start: Vector2) -> void:
global_position = position_start
velocity = Vector2.ZERO
alive = true
