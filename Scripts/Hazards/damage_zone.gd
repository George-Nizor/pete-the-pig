class_name DamageZone extends Area2D

@export var damage: int
@export var knockback := 1000

func damagezone():
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	print("Entered")
	body.knockback = position.direction_to(body.position) * knockback
