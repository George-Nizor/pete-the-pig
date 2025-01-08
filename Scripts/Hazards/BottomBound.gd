extends Node
@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	print("You died dumb fuck")
	body.rotate(240)
	body.get_node("Player_Collision").queue_free()
	Engine.time_scale = 0.5
	timer.start()

func _on_timer_timeout():
	Engine.time_scale = 1
	get_tree().reload_current_scene()
	EventManager.reset_score()
