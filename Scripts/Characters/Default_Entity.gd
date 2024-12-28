class_name DefaultEntity
extends CharacterBody2D

enum entity_type_list {PLAYER, ENEMY, PICKUP, HAZARD}
@export var entity_type: entity_type_list
@export var Health: HealthComponent
@export var Hitbox: HitBoxComponent

func _ready() -> void:
	Health.EntityKilled.connect(destroy_entity)
	Health.EntityDamaged.connect(entity_damaged)
	Health.EntityHealed.connect(entity_healed)

func destroy_entity():
	queue_free()
	
func entity_damaged():
	pass
	
func entity_healed():
	pass
