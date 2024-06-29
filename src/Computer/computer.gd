extends Node2D

# Declare member variables for the sprites
@export var sprite1 : Sprite2D
@export var sprite2 : Sprite2D
@export var timeToChange = 0.1

var show_sprite1 = true
var can_toggle = true

# Called when the node enters the scene tree for the first time.
func _ready():
	# Initially show only the first sprite
	sprite1.visible = true
	sprite2.visible = false
	
	# Reference the timer node
	var timer = $Timer
	timer.wait_time = timeToChange
	timer.one_shot = true
	timer.connect("timeout", Callable(self, "_on_Timer_timeout"))

func _unhandled_input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE:
		if can_toggle:
			toggle_sprites()

# Function to toggle between sprites
func toggle_sprites():
	show_sprite1 = !show_sprite1
	sprite1.visible = show_sprite1
	sprite2.visible = not show_sprite1
	
	# Start the timer to block input
	can_toggle = false
	$Timer.start()

func _on_Timer_timeout():
	# Re-enable input after the timer runs out
	can_toggle = true
