extends Node

signal rewarded_completed(reward_type: String)

var interstitial_counter := 0
var no_ads := false

func _ready() -> void:
if Engine.has_singleton("AdMob"):
var admob = Engine.get_singleton("AdMob")
admob.initialize()
admob.load_rewarded("rewarded_continue")
admob.load_interstitial("interstitial_session")

func maybe_show_interstitial() -> void:
if no_ads:
return
interstitial_counter += 1
if interstitial_counter % 3 != 0:
return
if Engine.has_singleton("AdMob"):
Engine.get_singleton("AdMob").show_interstitial("interstitial_session")

func show_rewarded_continue() -> void:
if Engine.has_singleton("AdMob"):
Engine.get_singleton("AdMob").show_rewarded("rewarded_continue")
else:
emit_signal("rewarded_completed", "continue")

func process_iap(product_id: String) -> void:
if product_id == "remove_ads":
no_ads = true
