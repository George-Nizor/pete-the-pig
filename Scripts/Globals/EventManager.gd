extends Node
var CURRENT_SCORE: int
var CURRENT_HEALTH: int
var player: DefaultEntity

func add_score(amount):
	CURRENT_SCORE += amount
	
func reset_score():
	CURRENT_SCORE = 0
	
func reload_scene():
	await get_tree().create_timer(3).timeout
	get_tree().reload_current_scene()
	

	
