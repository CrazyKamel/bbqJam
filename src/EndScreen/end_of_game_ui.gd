extends Control

var scoreToDisplay : int
@export var labelToWrite : Label
@export var logoWin : Sprite2D
@export var logoLose : Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	scoreToDisplay = int(Global.minigameScore/100) + 5 
	if(Global.gameWon):
		labelToWrite.text = "Après une bonne journée bien investie, vous pouvez maintenant partir en vacance avec vos " + str(scoreToDisplay) + " jours de congé payé!!"
		logoWin.show()
		logoLose.hide()
	else:
		labelToWrite.text = "Ton patron, voyant que tu n'avais pas assez de travail t'en as redonné, tu en as au moins pour " + str(scoreToDisplay) + " en heures supplémentaires"
		logoWin.hide()
		logoLose.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_button_replay_pressed():
	Global.minigameScore = 0
	Global.openspaceScore = 0
	Global.gameEnded = false
	Global.gameWon = false
	Global.goto_scene("res://src/OpenSpace/openSpace.tscn")
	

func _on_button_quit_pressed():
	get_tree().quit()
