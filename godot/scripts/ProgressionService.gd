extends Node

func grant_run_rewards(score: int, combo_peak: int) -> int:
var reward := score + int(combo_peak * 0.5)
SaveService.add_coins(reward)
if score >= 50:
_unlock("skin_quantum")
if score >= 100:
_unlock("world_ion_grid")
if combo_peak >= 12:
_unlock("trail_overdrive")
return reward

func _unlock(item_id: String) -> void:
if item_id.begins_with("skin_") and not SaveService.data.unlocked_skins.has(item_id):
SaveService.data.unlocked_skins.append(item_id)
if item_id.begins_with("trail_") and not SaveService.data.unlocked_trails.has(item_id):
SaveService.data.unlocked_trails.append(item_id)
if item_id.begins_with("world_") and not SaveService.data.unlocked_worlds.has(item_id):
SaveService.data.unlocked_worlds.append(item_id)
SaveService.save_data()
