class_name SoundPlayer extends Node

@export var hit_sound: AudioStreamPlayer
@export var death_sound: AudioStreamPlayer
@export var jump_sound: AudioStreamPlayer
@export var double_jump_sound: AudioStreamPlayer
@export var walk_sound: AudioStreamPlayer
@export var bark_sound: AudioStreamPlayer2D

func randomize_pitch(sound,low,high):
	sound.pitch_scale = randf_range(low,high)
	return sound

func hit_effect():
	randomize_pitch(hit_sound,0.8,1.6)
	hit_sound.play()
	
func death_effect():
	death_sound.play()
	
func jump_effect():
	randomize_pitch(jump_sound,1,1.5)
	jump_sound.play()
	
func double_jump_effect():
	randomize_pitch(double_jump_sound,1,1.8)
	double_jump_sound.play()

func walk_effect():
	randomize_pitch(walk_sound,1,1.3)
	walk_sound.play()
	
func bark_effect():
	randomize_pitch(bark_sound,0.8,1.1)
	bark_sound.play()
	
