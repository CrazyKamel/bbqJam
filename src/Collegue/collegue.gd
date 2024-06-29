extends Node2D

@export var speed = 400


# Called when the node enters the scene tree for the first time.
func _ready():
	print(get_viewport_rect().size)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += speed*delta
	#print(position.x)
	if position.x >= get_viewport_rect().size.x - $Sprite2D.texture.get_width():
		print("Collegue killed")
		get_parent().collegueDiedRIP()
		queue_free()
	pass
