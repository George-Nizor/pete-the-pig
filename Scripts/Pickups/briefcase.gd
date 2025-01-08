extends StaticBody2D

signal picked_up
@export var PickupSound: AudioStreamPlayer2D
@export var Sprite: AnimatedSprite2D

func briefcase():
	pass
	
func _on_pickup_area_body_entered(body: Node2D) -> void:
	if body.has_method("Player"):
		Sprite.queue_free()
		PickupSound.play()
		await get_tree().create_timer(PickupSound.stream.get_length()).timeout
		picked_up.emit()
		queue_free()
