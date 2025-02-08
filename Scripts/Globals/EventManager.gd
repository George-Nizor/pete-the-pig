extends Node
@onready var save_data: SaveData = SaveData.load_or_create()
var CURRENT_SCORE: int
var CURRENT_HEALTH: int
var player: DefaultEntity
var speedrun_time: float = 0.0
@onready var best_time = save_data.best_time
var player_dying_status = false

func add_score(amount):
	CURRENT_SCORE += amount
	
func reset_score():
	CURRENT_SCORE = 0
	
func reload_scene():
	await get_tree().create_timer(3).timeout
	EventManager.player_dying_status = false
	get_tree().reload_current_scene()

	
func format_seconds_to_hhmmss(seconds: float) -> String:
	var total_seconds = int(seconds)
	var hours = total_seconds / 3600
	var minutes = (total_seconds / 60) % 60
	var secs = total_seconds % 60
	return "%02d:%02d:%02d" % [hours, minutes, secs]
