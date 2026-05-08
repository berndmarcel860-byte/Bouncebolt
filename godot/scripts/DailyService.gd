extends Node

func _ready() -> void:
ensure_daily_mission()

func claim_daily_reward() -> int:
var today := _today_string()
if SaveService.data.last_daily_claim == today:
return 0
if SaveService.data.last_daily_claim == _date_offset(-1):
SaveService.data.daily_streak += 1
else:
SaveService.data.daily_streak = 1
SaveService.data.last_daily_claim = today
var reward := min(7, SaveService.data.daily_streak) * 25
SaveService.add_coins(reward)
SaveService.save_data()
return reward

func ensure_daily_mission() -> void:
var today := _today_string()
if SaveService.data.mission_date == today:
return
SaveService.data.mission_date = today
SaveService.data.mission_target = 10 + int(Time.get_unix_time_from_system() % 15)
SaveService.save_data()

func mission_completed(score: int) -> bool:
return score >= int(SaveService.data.mission_target)

func _today_string() -> String:
var now = Time.get_datetime_dict_from_system()
return "%04d-%02d-%02d" % [now.year, now.month, now.day]

func _date_offset(day_delta: int) -> String:
var unix := Time.get_unix_time_from_system() + day_delta * 86400
var dt = Time.get_datetime_dict_from_unix_time(unix)
return "%04d-%02d-%02d" % [dt.year, dt.month, dt.day]
