extends Node2D

var confirmQuit = preload("res://src/ConfirmQuit/confirmQuit.tscn")
@export var collegue: PackedScene
var timer := Timer.new()

var score = 0
var confirmQuitCheck = true

func collegueDiedRIP():
	print("HE DIED NOOOOOOOOOOOOOOOOO")
	if Input.is_action_pressed("space"):
		print("Grillé")
		var label = Label.new()
		label.text = "YOU DIED"
		add_child(label)
		timer.stop()
		# GAME OVER


	pass

func _spawnCollegue():
	print("Created collegue")
	var collegue1 = collegue.instantiate()
	#collegue1.position = Vector2(randf_range(0.0,1920.0), randf_range(0.0, 1080.0))
	collegue1.position = Vector2(50,50)
	add_child(collegue1)
	timer.wait_time = randi_range(1, 3)
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.one_shot = false
	timer.wait_time = randi_range(1, 5) 
	timer.connect("timeout", _spawnCollegue)
	add_child(timer)
	timer.start()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("space"):
		score += 20
		if score%100 == 0:
			print(score)
	pass

func _input(event):
	if event.is_action_pressed("ui_cancel") && confirmQuitCheck:
		var confirmQuitInstance = confirmQuit.instantiate()
		add_child(confirmQuitInstance)
		confirmQuitCheck = false

func subscribeCancelQuit():
	confirmQuitCheck = true
