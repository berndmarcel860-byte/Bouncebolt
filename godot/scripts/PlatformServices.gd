extends Node

func submit_leaderboard(score: int) -> void:
if Engine.has_singleton("PlayGamesServices"):
var pgs = Engine.get_singleton("PlayGamesServices")
pgs.submit_score("leaderboard_high_score", score)

func unlock_achievement(achievement_id: String) -> void:
if Engine.has_singleton("PlayGamesServices"):
var pgs = Engine.get_singleton("PlayGamesServices")
pgs.unlock_achievement(achievement_id)
