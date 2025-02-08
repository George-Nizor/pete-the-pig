class_name Level
extends Node

var objectiveAmount: int
@export var LevelNumber: int
@export var NextLevel: PackedScene
@export var end_level_screen: EndLevelScreen
var EndLevelText: String

func _ready() -> void:
	var children = get_node('Briefcases').get_children()
	print(NextLevel.resource_path.get_file().get_basename())
	for node in children:
		if node.has_method("briefcase"):
			objectiveAmount += 1
			node.picked_up.connect(_on_briefcase_picked_up)
	RenderingServer.set_default_clear_color(Color("#453d4f"))


func load_next_level():
	if NextLevel.resource_path.get_file().get_basename() == "main_menu":
		print("This check works")
		print(EventManager.speedrun_time)
		print(EventManager.best_time)
		if (float(EventManager.speedrun_time) < EventManager.best_time) or EventManager.best_time == 0.0:
			print("Saving new time")
			EventManager.best_time = EventManager.speedrun_time
			EventManager.format_seconds_to_hhmmss(EventManager.best_time)
			EventManager.save_data.best_time = EventManager.best_time
			EventManager.save_data.save()
			print("saved")
	if end_level_screen:
		end_level_screen.reveal_screen()
	await get_tree().create_timer(5).timeout
	get_tree().change_scene_to_packed(NextLevel)


func _on_briefcase_picked_up():
	EventManager.add_score(1)
	if EventManager.CURRENT_SCORE == objectiveAmount:
		load_next_level()
		EventManager.reset_score()
