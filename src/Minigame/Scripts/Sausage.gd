extends RigidBody2D

signal clicked

var held = false
var cooking = false
var burning_sound = preload("res://media/Sounds/Sausage/8bit-burning.mp3")
# 0 : Raw, 1 : Cooking, 2 : Cooked, 3 : Burnt
var state = 0

var time_cooking = 0.0

@onready var animated_sprite_2d = $AnimatedSprite2D

func _ready():
	get_parent().connect_to_pickable(self)

func _process(delta):
	if cooking:
		time_cooking += delta

	match state:
		0:
			if ( time_cooking >= 5 ):
				state = 1
				print("Sausage cooking!")
				$AnimatedSprite2D.animation = "Cooking"
		1:
			if ( time_cooking >= 15 ):
				state = 2
				print("Sausage cooked!")
				$AnimatedSprite2D.animation = "Cooked"
		2:
			if ( time_cooking >= 25 ):
				state = 3
				print("Sausage burnt!")
				$AnimatedSprite2D.animation = "Burnt"
				$CPUParticles2D.emitting = true
				$SausageAudio.stream = burning_sound
				$SausageAudio.play()
		3:
			if ( time_cooking >= 30 ):
				Global.minigameScore-=5
				drop()
				get_parent().disconnect_from_pickable(self)
				call_deferred("free")

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			clicked.emit(self)

func _physics_process(delta):
	if held:
		global_transform.origin = get_global_mouse_position()
		
func pickup():
	if held:
		return
	freeze = true
	held = true
	
func drop(impulse=Vector2.ZERO):
	if held:
		freeze = false
		apply_central_impulse(impulse)
		held = false
