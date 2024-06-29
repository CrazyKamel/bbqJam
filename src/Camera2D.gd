extends Camera2D

# Define the key for switching views
const SWITCH_VIEW_KEY = KEY_TAB
var officeZoomed = false

# Define the zoom increment
const ZOOM_POWER = 10

# Store the original zoom level and position
var original_zoom = Vector2(1, 1)
var original_position = Vector2()

# Define the object to focus on
@export var target: Node2D

func _ready():
	original_zoom = zoom
	original_position = global_position

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			if event.keycode == SWITCH_VIEW_KEY:
				if officeZoomed:
					zoom_out()
				else:
					zoom_in()
				officeZoomed = !officeZoomed

func zoom_in():
	if target:
		# Store the original zoom level and position
		original_zoom = zoom
		original_position = global_position
		
		# Set the zoom level to a defined value
		zoom = Vector2(ZOOM_POWER, ZOOM_POWER)  # Change this value as needed
		focus_on_target()

func zoom_out():
	# Restore the original zoom level and position
	zoom = original_zoom
	global_position = original_position

func focus_on_target():
	if target:
		# Calculate the new position to focus on the target
		global_position = target.global_position
