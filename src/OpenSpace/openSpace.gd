extends Node2D

var confirmQuit = preload("res://src/ConfirmQuit/confirmQuit.tscn")
@export var collegue: PackedScene
var timer := Timer.new()

var score = 0
var confirmQuitCheck = true

# Define the key for switching views
const SWITCH_VIEW_KEY = KEY_TAB
var officeZoomed = false

@onready var openspace_cam = $Openspace_Cam
@onready var minigame_cam = $Minigame_Cam


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
	openspace_cam.make_current()
	timer.one_shot = false
	timer.wait_time = randi_range(1, 5) 
	timer.connect("timeout", _spawnCollegue)
	add_child(timer)
	timer.start()
	$Clock.gameTimesUp.connect(onGameEnd);
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
	if event is InputEventKey:
		if event.pressed:
			if event.keycode == SWITCH_VIEW_KEY:
				# officeZoomed = !officeZoomed
				swapCamera()

func swapCamera():
	if openspace_cam.is_current():
		minigame_cam.make_current()
	else:
		openspace_cam.make_current()

func subscribeCancelQuit():
	confirmQuitCheck = true
	
func onGameEnd():
	print("jeu fini")
