class_name DamageZone extends Area2D

@export var damage: int
@export var knockback := 1000

func damagezone():
	pass

#func _on_body_entered(body: Node2D) -> void:
	#print("Entered")
	#body.knockback = position.direction_to(body.position) * knockback
