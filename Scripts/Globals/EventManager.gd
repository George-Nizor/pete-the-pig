extends Node
var CURRENT_SCORE: int
var CURRENT_HEALTH: int
var player: DefaultEntity

func add_score(amount):
	CURRENT_SCORE += amount
	
func reset_score():
	CURRENT_SCORE = 0
	
	

	
