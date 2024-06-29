extends Node2D

# Declare member variables for the sprites
@export var sprite1 : Sprite2D
@export var sprite2 : Sprite2D
var show_sprite1 = true

func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed:
			if event.keycode == KEY_SPACE:
				toggle_sprites()

# Called when the node enters the scene tree for the first time.
func _ready():
	# Initially show only the first sprite
	sprite1.visible = true
	sprite2.visible = false

# Function to toggle between sprites
func toggle_sprites():
	show_sprite1 = !show_sprite1
	sprite1.visible = show_sprite1
	sprite2.visible = not show_sprite1
