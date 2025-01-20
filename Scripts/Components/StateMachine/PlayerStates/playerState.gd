class_name playerState extends State

@export var Player: DefaultEntity

func get_input_axis() -> float:
	return Input.get_axis("move_left", "move_right")
