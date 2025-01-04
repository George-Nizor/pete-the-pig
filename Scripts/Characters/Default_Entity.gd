class_name DefaultEntity
extends CharacterBody2D

enum entity_type_list {PLAYER, ENEMY, PICKUP, HAZARD}
@export var entity_type: entity_type_list
@export var Health: HealthComponent
@export var Hitbox: HitBoxComponent
@export var Effects_Player: EffectsPlayer
@export var SoundPlayer: SoundPlayer
@export var Collision_Shape: CollisionShape2D

func _ready() -> void:
	if Health:
		Health.EntityKilled.connect(destroy_entity)
		Health.EntityDamaged.connect(entity_damaged)
		Health.EntityHealed.connect(entity_healed)

func destroy_entity():
	rotate(240)
	Collision_Shape.queue_free()
	await get_tree().create_timer(0.5).timeout
	queue_free()
	
func entity_damaged():
	if Effects_Player:
		Effects_Player.hit_effect()
		if SoundPlayer:
			SoundPlayer.hit_effect()
	
func entity_healed():
	pass
