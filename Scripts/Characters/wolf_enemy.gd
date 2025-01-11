extends DefaultEntity

var direction = -1
@export var ray_cast_right: RayCast2D 
@export var ray_cast_left: RayCast2D
@export var sprite: AnimatedSprite2D
@export var SPEED = 100

func Enemy():
	pass

func _physics_process(delta: float) -> void:
	apply_gravity(delta)

func _process(delta: float) -> void:
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
	
	
func _on_wolf_sprite_frame_changed() -> void:
	var walk_frames = [1,3]
	if sprite.animation == "idle": return
	if sprite.animation == "jump": return
	if sprite.frame in walk_frames: SoundPlayer.bark_effect()
