extends Node2D

# Declare member variables for the sprites
@export var excel_sprite : Sprite2D
@export var game_sprite : Sprite2D
@export var timeToChange = 0.1

var show_excel_sprite = true
var can_toggle = true

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Ready")
	# Initially show only the first sprite
	excel_sprite.visible = true
	game_sprite.visible = false
	
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
	can_toggle = false
	
	print("Excel/Game")
	show_excel_sprite = !show_excel_sprite
	excel_sprite.visible = show_excel_sprite
	game_sprite.visible = not show_excel_sprite
	
	# Start the timer to block input
	await get_tree().create_timer(0.5).timeout
	can_toggle = false

func _on_Timer_timeout():
	# Re-enable input after the timer runs out
	can_toggle = true
