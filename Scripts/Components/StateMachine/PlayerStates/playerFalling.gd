extends playerState

func Physics_Update(delta: float):
	var input_axis = get_input_axis()
	if Player.is_on_floor() and input_axis > 0:
		Transitioned.emit(self,"Running")
	elif Player.is_on_floor() and input_axis == 0:
		Transitioned.emit(self,"Idle")
	elif Player.velocity.y < 0:
		Transitioned.emit(self, "Jumping")
