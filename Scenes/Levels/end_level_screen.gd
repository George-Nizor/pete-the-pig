extends Control
class_name EndLevelScreen

@export var level: Level
@export var text_label: Label
@export var text_background: TextureRect
@onready var display_text = level.EndLevelText

func _ready():
	# Initialize the label and background with their starting values
	text_label.visible_ratio = 0.0
	text_background.modulate.a = 0.0

func reveal_screen():
	#"Wow Pete \n you got that Mula!"
	display_text = level.EndLevelText
	text_label.text = display_text
	# Create a new tween
	print(display_text)
	var tween = create_tween()

	# Set transitions and ease for smooth animations
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.set_ease(Tween.EASE_IN_OUT)

	# Animate the visible_ratio of the label and the alpha of the background simultaneously
	tween.tween_property(text_background, "modulate:a", 0.7, 0.1)  # Animate the background fade-in
	tween.tween_property(text_label, "visible_ratio", 1.0 , 2.0)  # Animate the text appearance
	
