extends Node

const SAVE_PATH := "user://bounce_bolt_save.json"

var data := {
"high_score": 0,
"coins": 0,
"sessions": 0,
"unlocked_skins": ["default"],
"unlocked_trails": ["plasma"],
"unlocked_effects": ["pulse"],
"unlocked_worlds": ["core_tunnel"],
"achievements": {},
"last_daily_claim": "",
"daily_streak": 0,
"mission_date": "",
"mission_target": 10
}

func _ready() -> void:
load_data()

func load_data() -> void:
if not FileAccess.file_exists(SAVE_PATH):
save_data()
return
var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
if file == null:
return
var parsed = JSON.parse_string(file.get_as_text())
if typeof(parsed) == TYPE_DICTIONARY:
for key in parsed:
data[key] = parsed[key]

func save_data() -> void:
var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
if file != null:
file.store_string(JSON.stringify(data))

func add_coins(amount: int) -> void:
data.coins += max(0, amount)
save_data()

func set_high_score(new_score: int) -> void:
data.high_score = max(data.high_score, new_score)
save_data()
