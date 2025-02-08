extends Label

var time = EventManager.speedrun_time

func _physics_process(delta):
	time += delta
	update_ui()

func format_seconds_to_hhmmss(seconds: float) -> String:
	var total_seconds = int(seconds)
	var hours = total_seconds / 3600
	var minutes = (total_seconds / 60) % 60
	var secs = total_seconds % 60
	return "%02d:%02d:%02d" % [hours, minutes, secs]

func update_ui():
	# Extract milliseconds
	var milliseconds = int((time - int(time)) * 100)  # Get two decimal places

	# Get formatted HH:MM:SS
	var formatted_hhmmss = format_seconds_to_hhmmss(time)

	# Combine HH:MM:SS with milliseconds
	var final_time_string = "%s.%02d" % [formatted_hhmmss, milliseconds]

	# Store in EventManager and update label text
	EventManager.speedrun_time = time
	self.text = final_time_string
