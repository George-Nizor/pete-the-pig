extends playerState
class_name playerJumping

func Enter():
	pass
	
func Physics_Update(delta: float):
	var input_axis = get_input_axis()
	if Player.velocity.y > 0:
		Transitioned.emit(self, "Falling")
