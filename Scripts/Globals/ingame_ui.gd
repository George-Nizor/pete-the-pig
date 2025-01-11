extends Control

@export var player: DefaultEntity
@onready var current_health = player.Health.Health
@onready var current_score = EventManager.CURRENT_SCORE
@onready var health_1: ColorRect = $Health1
@onready var health_2: ColorRect = $Health2
@onready var scorebox = $Score
@onready var objectivebox = $Objective
var objective: int
@onready var level = get_parent().get_parent()

func _ready() -> void:
	await level.ready 
	objective = level.objectiveAmount
	objectivebox.text = str(objective)


func _process(delta: float) -> void:
	if is_instance_valid(player):
		current_health = player.Health.Health
		current_score = EventManager.CURRENT_SCORE
		scorebox.text = str(current_score)
		if current_health == 100:
			health_2.visible = false
		if current_health == 0:
			health_1.visible = false
	
