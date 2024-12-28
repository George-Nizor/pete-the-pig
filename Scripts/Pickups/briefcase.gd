extends StaticBody2D

signal picked_up

func briefcase():
	pass
	
func _on_pickup_area_body_entered(body: Node2D) -> void:
	if body.has_method("Player"):
		picked_up.emit()
		queue_free()
