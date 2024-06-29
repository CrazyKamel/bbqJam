extends Control

var scoreToDisplay : int
@export var labelToWrite : Label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	scoreToDisplay = int(Global.minigameScore/100) + 5 
	labelToWrite.text = "Après une bonne journée bien investie, vous pouvez maintenant partir en vacance avec vos " + str(scoreToDisplay) + " jours de congé payé!!"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_button_replay_pressed():
	Global.minigameScore = 0
	Global.openspaceScore = 0
	Global.goto_scene("res://src/OpenSpace/openSpace.tscn")
	

func _on_button_quit_pressed():
	get_tree().quit()
