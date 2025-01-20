extends playerState
class_name playerIdle

func Physics_Update(delta: float):
	var input_axis = get_input_axis()
	if input_axis != 0 and Player.is_on_floor():
		Transitioned.emit(self, "Running")
		
	elif Player.is_on_floor() or Player.coyote_jump_timer.time_left > 0.0:
		if InputManager.jump_pressed:  # Changed to just_pressed
			Transitioned.emit(self, "Jumping")
