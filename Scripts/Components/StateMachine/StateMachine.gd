class_name StateMachine
extends Node

@export var initial_state: State

var current_state: State
var states: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
			print(child, "connected")
			
	if initial_state:
		current_state = initial_state
		current_state.Enter()
		print("Initial state: ", current_state.name)
			
func _process(delta: float) -> void:
	if current_state:
		current_state.Update(delta)
		
func _physics_process(delta: float) -> void:
	if current_state:
		current_state.Physics_Update(delta)

func on_child_transition(state, new_state_name):
	if state != current_state:
		return
		
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		print("Could not find state: ", new_state_name)
		return
		
	if current_state:
		current_state.Exit()
	
	new_state.Enter()
	
	current_state = new_state
	print(current_state)
