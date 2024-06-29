extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	Global.minigameScore = 0
	Global.openspaceScore = 0
	Global.goto_scene("res://src/OpenSpace/openSpace.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
