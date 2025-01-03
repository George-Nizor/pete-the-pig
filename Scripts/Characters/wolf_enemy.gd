extends DefaultEntity

var direction = -1
@export var ray_cast_right: RayCast2D 
@export var ray_cast_left: RayCast2D
@export var sprite: AnimatedSprite2D
@export var SPEED = 100

func Enemy():
	pass

func _process(delta: float) -> void:
	apply_gravity(delta)
	if ray_cast_right.is_colliding():
		direction = -1
		sprite.flip_h = false
	if ray_cast_left.is_colliding():
		direction = 1
		sprite.flip_h = true
	velocity.x = direction * SPEED
	move_and_slide()
	
func apply_gravity(delta):
	if not is_on_floor():
		velocity += get_gravity() * 1 * delta
	
