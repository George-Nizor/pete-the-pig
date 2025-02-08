extends Control
@onready var best_time: Label = $Best_time

func _ready() -> void:
	EventManager.speedrun_time = 0
	best_time.text = "Best Time: " + str(EventManager.best_time)
	print(EventManager.best_time)
	

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Levels/level_1.tscn")

func _on_quit_button_pressed() -> void:
	EventManager.save_data.save()
	get_tree().quit()
