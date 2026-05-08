extends Node2D

signal passed
signal hit_player

var move_speed := 360.0
var recycled := false

@onready var top_body: StaticBody2D = $Top
@onready var bottom_body: StaticBody2D = $Bottom
@onready var gate: Area2D = $ScoreGate

func _ready() -> void:
gate.body_entered.connect(_on_gate_body_entered)

func configure(gap_center_y: float, gap_size: float, speed: float) -> void:
move_speed = speed
recycled = false
top_body.position = Vector2.ZERO
bottom_body.position = Vector2.ZERO
gate.position = Vector2.ZERO
top_body.position.y = gap_center_y - gap_size * 0.5 - 350.0
bottom_body.position.y = gap_center_y + gap_size * 0.5 + 350.0
gate.position.y = gap_center_y

func _process(delta: float) -> void:
position.x -= move_speed * delta
if position.x < -250.0 and not recycled:
recycled = true

func _on_gate_body_entered(_body: Node) -> void:
if recycled:
return
emit_signal("passed")
gate.monitoring = false

func reset_for_pool(spawn_x: float) -> void:
position.x = spawn_x
gate.monitoring = true
recycled = false
