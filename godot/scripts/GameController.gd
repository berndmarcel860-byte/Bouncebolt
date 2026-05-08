extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var spawner: Node = $Spawner
@onready var score_label: Label = $HUD/Score
@onready var combo_label: Label = $HUD/Combo
@onready var high_score_label: Label = $HUD/HighScore
@onready var mission_label: Label = $HUD/Mission
@onready var status_label: Label = $HUD/Status
@onready var retry_button: Button = $HUD/RetryButton
@onready var reward_button: Button = $HUD/RewardButton

var score := 0
var combo := 0
var combo_peak := 0
var alive := true
var revived_this_run := false
var difficulty_timer := 0.0

func _ready() -> void:
player.died.connect(_on_player_died)
retry_button.pressed.connect(_on_retry_pressed)
reward_button.pressed.connect(_on_reward_continue)
MonetizationService.rewarded_completed.connect(_on_rewarded_completed)
start_run()

func _process(delta: float) -> void:
if not alive:
return
difficulty_timer += delta
spawner.process_spawning(delta, difficulty_timer, Callable(self, "_on_obstacle_passed"), Callable(self, "_on_player_died"))
if Input.is_action_just_pressed("tap"):
player.bounce()

func _unhandled_input(event: InputEvent) -> void:
if event is InputEventScreenTouch and event.pressed and alive:
player.bounce()

func _on_obstacle_passed() -> void:
combo += 1
combo_peak = max(combo_peak, combo)
var multiplier := 1 + int(combo / 5)
score += multiplier
_update_hud()

func _on_player_died() -> void:
if not alive:
return
alive = false
combo = 0
SaveService.set_high_score(score)
PlatformServices.submit_leaderboard(score)
var reward = ProgressionService.grant_run_rewards(score, combo_peak)
if DailyService.mission_completed(score):
PlatformServices.unlock_achievement("daily_mission_complete")
status_label.text = "Crashed! +%d coins" % reward
retry_button.visible = true
reward_button.visible = not revived_this_run
MonetizationService.maybe_show_interstitial()
_update_hud()

func _on_retry_pressed() -> void:
start_run()

func _on_reward_continue() -> void:
MonetizationService.show_rewarded_continue()

func _on_rewarded_completed(reward_type: String) -> void:
if reward_type != "continue" or revived_this_run or alive:
return
revived_this_run = true
alive = true
player.alive = true
player.velocity = Vector2.ZERO
status_label.text = "Second chance activated"
reward_button.visible = false
retry_button.visible = false

func start_run() -> void:
score = 0
combo = 0
combo_peak = 0
difficulty_timer = 0.0
alive = true
revived_this_run = false
SaveService.data.sessions += 1
SaveService.save_data()
spawner.reset_state()
player.reset_player(Vector2(300, 960))
mission_label.text = "Mission: Reach score %d" % int(SaveService.data.mission_target)
status_label.text = "Tap to bounce"
retry_button.visible = false
reward_button.visible = false
_update_hud()

func _update_hud() -> void:
score_label.text = "Score: %d" % score
combo_label.text = "Combo x%d" % max(1, combo)
high_score_label.text = "Best: %d" % int(SaveService.data.high_score)
