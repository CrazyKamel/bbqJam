extends Node2D
var endScreen = preload("res://src/EndScreen/end_of_game_ui.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var endScreenIsntance = endScreen.instantiate()
	add_child(endScreenIsntance)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
