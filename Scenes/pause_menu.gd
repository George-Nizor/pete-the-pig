extends Control


@onready var volume_slider = $PanelContainer/VBoxContainer/Vol_Slider


func _ready() -> void:
	$AnimationPlayer.play("RESET")
	visible = false
	self.set_process_input(false) 

func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")
	visible = false
	self.set_process_input(false)
	
func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	visible = true
	self.set_process_input(true)
	
func testEsc():
	if EventManager.player_dying_status == false:
		if Input.is_action_just_pressed("esc") and get_tree().paused == false:
			pause()
		elif Input.is_action_just_pressed("esc") and get_tree().paused == true:
			resume()


func _on_resume_pressed() -> void:
	resume()


func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	EventManager.reset_score()


func _on_exit_pressed() -> void:
	resume()
	get_tree().quit()
	
func _process(delta: float) -> void:
	testEsc()
