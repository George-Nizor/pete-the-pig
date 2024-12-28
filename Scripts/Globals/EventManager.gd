extends Node
var CURRENT_SCORE: int

func add_score(amount):
	CURRENT_SCORE += amount
	
func reset_score():
	CURRENT_SCORE = 0
	
