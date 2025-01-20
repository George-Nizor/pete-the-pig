extends Node

class_name _InputManager

var jump_pressed: bool = false

func _input(event):
	if Input.is_action_pressed("jump"):
		jump_pressed = true
	elif Input.is_action_just_released("jump"):
		jump_pressed = false
	
	#print("Jump is %s"%[jump_pressed])
