class_name Level
extends Node

var objectiveAmount: int
@export var LevelNumber: int
@export var NextLevel: PackedScene
@export var end_level_screen: EndLevelScreen
var EndLevelText: String

func _ready() -> void:
	var children = get_node('Briefcases').get_children()
	for node in children:
		if node.has_method("briefcase"):
			objectiveAmount += 1
			node.picked_up.connect(_on_briefcase_picked_up)

func load_next_level():
	end_level_screen.reveal_screen()
	await get_tree().create_timer(5).timeout
	get_tree().change_scene_to_packed(NextLevel)
	pass

func _on_briefcase_picked_up():
	EventManager.add_score(1)
	if EventManager.CURRENT_SCORE == objectiveAmount:
		load_next_level()
		EventManager.reset_score()
