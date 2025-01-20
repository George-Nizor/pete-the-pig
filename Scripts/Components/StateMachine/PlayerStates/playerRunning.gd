extends playerState
class_name playerRunning

func Enter():
	pass
	
func Physics_Update(delta: float):
	var input_axis = get_input_axis()
	var was_on_floor = Player.is_on_floor()
	var just_left_ledge = was_on_floor and not Player.is_on_floor() and Player.velocity.y >= 0
	if just_left_ledge:
		Player.coyote_jump_timer.start()
	if input_axis == 0 and Player.is_on_floor():
		Transitioned.emit(self, "Idle")
	if Player.is_on_floor() or Player.coyote_jump_timer.time_left > 0.0:
		if InputManager.jump_pressed == true:  # Changed to just_pressed
			Transitioned.emit(self, "Jumping")
