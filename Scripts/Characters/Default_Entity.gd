class_name DefaultEntity
extends CharacterBody2D

enum entity_type_list {PLAYER, ENEMY, PICKUP, HAZARD}
@export var entity_type: entity_type_list
@export var Health: HealthComponent
@export var Hitbox: HitBoxComponent
@export var Effects_Player: EffectsPlayer
@export var SoundPlayer: SoundPlayer
@export var Collision_Shape: CollisionShape2D
@export var DamageZone: DamageZone

func _ready() -> void:
	call_deferred("connect_health_signals")
	
func connect_health_signals():
	if Health:
		Health.EntityKilled.connect(destroy_entity)
		Health.EntityDamaged.connect(entity_damaged)
		Health.EntityHealed.connect(entity_healed)
		print("Signals connected successfully!")

func destroy_entity():
	if SoundPlayer:
		SoundPlayer.death_effect()
	rotate(240)
	Hitbox.queue_free()
	if DamageZone:
		DamageZone.queue_free()
	set_process(false)
	await get_tree().create_timer(0.5).timeout
	queue_free()
	
func entity_damaged():
	if Effects_Player:
		Effects_Player.hit_effect()
		if SoundPlayer:
			SoundPlayer.hit_effect()
	
func entity_healed():
	pass
