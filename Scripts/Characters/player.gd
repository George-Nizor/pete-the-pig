extends DefaultEntity

@export var player_sprite: AnimatedSprite2D
@export var coyote_jump_timer: Timer
@export var wall_jump_timer: Timer
@export var movement_data: PlayerMovementData
@export var DamageTimer: Timer
var air_jump = false
var just_wall_jumped = false
var was_wall_normal = Vector2.ZERO
var damage = 100
@export var camera_2d: Camera2D
@export var KnockbackTimer: Timer


# Knockback Variables
var knockback_direction
var in_knockback = false

# Take damage state
@onready var can_take_damage = true

# Walking state
var walking = false

func _knockback(direction, delta):
	if KnockbackTimer.is_stopped():
		KnockbackTimer.start()
		# Apply initial knockback force only at the start
		velocity.x = 400 * direction  # Adjust force to suit your game scale
		# Gradually reduce the knockback effect
		velocity.x = move_toward(velocity.x, 0, 200 * delta)
		# Allow bounce for vertical movement
		move_and_slide()
		

func Player():
	pass

	
func _ready() -> void:
	# Call the parent class's _ready function
	super._ready()
	
	# Add player-specific setup here
	if camera_2d:
		camera_2d.limit_bottom = get_parent().get_node("BottomBound").global_position.y - 50


func _physics_process(delta):
	if in_knockback == true:
		print("getting knocked back")
		bounce()
		_knockback(knockback_direction,delta)
	else:
		apply_gravity(delta)
		handle_wall_jump()
		handle_jump()
		var input_axis = Input.get_axis("move_left", "move_right")
		handle_camera(input_axis)
		handle_acceleration(input_axis, delta)
		handle_air_acceleration(input_axis, delta)
		apply_friction(input_axis, delta)
		apply_air_resistance(input_axis, delta)
		var was_on_floor = is_on_floor()
		var was_on_wall = is_on_wall_only()
		if was_on_wall:
			was_wall_normal = get_wall_normal()
		move_and_slide()
		var just_left_ledge = was_on_floor and not is_on_floor() and velocity.y >= 0
		if just_left_ledge:
			coyote_jump_timer.start()
		just_wall_jumped = false
		var just_left_wall = was_on_wall and not is_on_wall()
		if just_left_wall:
			wall_jump_timer.start()
		update_animations(input_axis)

func handle_camera(input_axis):
	if camera_2d:
		var pan_speed = 0.01
		if input_axis:
			camera_2d.offset.x = lerp(camera_2d.offset.x,80 * input_axis,pan_speed)
		else:
			camera_2d.offset.x = lerp(camera_2d.offset.x,0.0,pan_speed / 10)
		

func apply_gravity(delta):
	if not is_on_floor():
		velocity += get_gravity() * movement_data.gravity_scale * delta


func handle_wall_jump():
	if not is_on_wall_only() and wall_jump_timer.time_left <= 0.0: return
	var wall_normal = get_wall_normal() 
	if wall_jump_timer.time_left > 0.0:
		wall_normal = was_wall_normal
	if Input.is_action_just_pressed("jump"):
		SoundPlayer.double_jump_effect()
		velocity.x = wall_normal.x * movement_data.speed * 1.2
		velocity.y = movement_data.jump_velocity * .8
		just_wall_jumped = true


func handle_jump():
	if is_on_floor(): air_jump = true

	
	if is_on_floor() or coyote_jump_timer.time_left > 0.0:
		if Input.is_action_pressed("jump"):
			SoundPlayer.jump_effect()
			velocity.y = movement_data.jump_velocity
			coyote_jump_timer.stop()
	elif not is_on_floor():
		if Input.is_action_just_released("jump") and velocity.y < movement_data.jump_velocity / 2:
			velocity.y = movement_data.jump_velocity / 2
		
		if Input.is_action_just_pressed("jump") and air_jump and not just_wall_jumped:
			SoundPlayer.double_jump_effect()
			velocity.y = movement_data.jump_velocity * 0.8
			air_jump = false


func handle_acceleration(input_axis, delta):
	if not is_on_floor(): return
	if input_axis != 0:
		velocity.x = move_toward(velocity.x, movement_data.speed * input_axis, movement_data.acceleration)


func handle_air_acceleration(input_axis, delta):
	if is_on_floor(): return
	if input_axis != 0:
		velocity.x = move_toward(velocity.x, movement_data.speed * input_axis, movement_data.air_acceleration)


func apply_friction(input_axis, delta):
	if input_axis == 0 and is_on_floor():
		velocity.x = move_toward(velocity.x, 0, movement_data.friction)


func apply_air_resistance(input_axis, delta):
	if input_axis == 0 and not is_on_floor():
		velocity.x = move_toward(velocity.x, 0, movement_data.air_resistance)


func update_animations(input_axis):
	if input_axis != 0:
		player_sprite.flip_h = (input_axis < 0)
		player_sprite.play("run")
	else:
		player_sprite.play("idle")
	
	if not is_on_floor():
		player_sprite.play("jump")
		
func bounce():
	velocity.y = movement_data.jump_velocity * 0.8
	air_jump = false
	

func _on_player_hit_box_area_entered(area: Area2D) -> void:
	var relative_position = global_position.x - area.global_position.x
	if can_take_damage == true:
		can_take_damage = false
		knockback_direction = -1 if relative_position < 0 else 1
		if area.has_method("damagezone"):
			Hitbox.damage(area.damage)
			in_knockback = true
		elif area.Entity.entity_type == 2 or area.Entity.entity_type == 3:
			Hitbox.damage(area.Entity.damage)
		DamageTimer.start()
		

func player_above(area):
	return global_position.y > area.global_position.y


func _on_attack_box_area_entered(area: Area2D) -> void:
	if can_take_damage:
		if area.Entity.has_method("Enemy"):
			if player_above(area):
				area.Entity.Health.ReduceHealth(damage)
				bounce()


func _on_damage_timer_timeout() -> void:
	can_take_damage = true


func _on_knockback_timer_timeout() -> void:
	in_knockback = false


func _on_player_sprite_frame_changed() -> void:
	var footstep_frames = [1,3]
	if player_sprite.animation == "idle": return
	if player_sprite.animation == "jump": return
	if player_sprite.frame in footstep_frames: SoundPlayer.walk_effect()


func destroy_entity():
	super()
	camera_2d.reparent(get_parent())
	print(camera_2d.get_parent())
	
