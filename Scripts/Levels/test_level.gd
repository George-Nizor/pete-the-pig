extends Level
@onready var polygon_2d: Polygon2D = $StaticBody2D/CollisionPolygon2D/Polygon2D
@onready var collision_polygon_2d: CollisionPolygon2D = $StaticBody2D/CollisionPolygon2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	polygon_2d.polygon = collision_polygon_2d.polygon
	super()
	EndLevelText = "Wow Pete \n you got that Mula!"
	print(EndLevelText)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
