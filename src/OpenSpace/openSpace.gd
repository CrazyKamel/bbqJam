extends Node2D

var confirmQuit = preload("res://src/ConfirmQuit/confirmQuit.tscn")
@export var collegue: PackedScene

@export var excel_sprite : Sprite2D
@export var game_sprite : Sprite2D

var show_excel_sprite = true
var can_toggle = true

var timer := Timer.new()
var doorTimer := Timer.new()
var retourJohn = false

var confirmQuitCheck = true

# Define the key for switching views
const SWITCH_VIEW_KEY = KEY_TAB

@onready var openspace_cam = $Openspace_Cam
@onready var minigame_cam = $Minigame_Cam
@onready var minigame = $Minigame_Cam/Minigame

var confirmQuitInstance

func toggle_sprites():
	if can_toggle:
		can_toggle = false
		print("Excel/Game")
		show_excel_sprite = !show_excel_sprite
		excel_sprite.visible = show_excel_sprite
		game_sprite.visible = not show_excel_sprite
		minigame.set_excel_visibility(show_excel_sprite)
		await get_tree().create_timer(0.2).timeout
		can_toggle = true

func collegueDiedRIP():
	print("HE DIED NOOOOOOOOOOOOOOOOO")
	if Input.is_action_pressed("space"):
		print("Grillé")
		var label = Label.new()
		label.text = "YOU DIED"
		add_child(label)
		timer.stop()
		# GAME OVER
		Global.gameEnded = true
		Global.gameWon = false
		Global._sendEndGameSingal()

	pass

func _spawnCollegue():
	print("Created collegue")
	var collegue1 = collegue.instantiate()
	#collegue1.position = Vector2(randf_range(0.0,1920.0), randf_range(0.0, 1080.0))
	collegue1.position = Vector2(50,50)
	add_child(collegue1)
	timer.wait_time = randi_range(3, 5)
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	
	excel_sprite.visible = true
	game_sprite.visible = false
	
	openspace_cam.make_current()
	timer.one_shot = true
	timer.wait_time = randi_range(1, 5) 
	timer.connect("timeout", _spawnCollegue)
	add_child(timer)
	timer.start()

	doorTimer.one_shot = false
	doorTimer.wait_time = randi_range(10, 20) 
	doorTimer.connect("timeout", _openDoor)
	add_child(doorTimer)
	doorTimer.start()
	Global.gameTimesUp.connect(onGameEnd)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("space"):
		toggle_sprites()
		Global.openspaceScore += 20
		if Global.openspaceScore%100 == 0:
			print(Global.openspaceScore)
	if $Openspace_Cam/Office/John.visible == true:
		if $Openspace_Cam/Office/John.position.x != 0 && ! retourJohn: 
			$Openspace_Cam/Office/John.position = $Openspace_Cam/Office/John.position.lerp(Vector2(0,0),25*delta)
		if $Openspace_Cam/Office/John.position.x < 0.0000001 || retourJohn :
			retourJohn = true
			$Openspace_Cam/Office/John.position = $Openspace_Cam/Office/John.position.lerp(Vector2(100,0),1*delta)
		
	pass

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if confirmQuitCheck:
			confirmQuitInstance = confirmQuit.instantiate()
			add_child(confirmQuitInstance)
			confirmQuitCheck = false
		else:
			subscribeCancelQuit();
			confirmQuitInstance.queue_free()
	if event is InputEventKey:
		if event.pressed:
			if event.keycode == SWITCH_VIEW_KEY:
				swapCamera()

func swapCamera():
	print("Swapped")
	if openspace_cam.is_current():
		minigame_cam.make_current()
	else:
		openspace_cam.make_current()
	await get_tree().create_timer(0.5).timeout
	Global.minigameView = !Global.minigameView
	

func subscribeCancelQuit():
	confirmQuitCheck = true
	
func onGameEnd():
		Global.goto_scene("res://src/backgroundEnd/end.tscn")

func _on_area_2d_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		swapCamera()
		
func _openDoor():
	doorTimer.wait_time = randi_range(10, 20) 
	var rand = randi_range(0,1)
	match rand:
		0:
			_openDoorLeft()
		1:
			_openDoorRight()

func _openDoorLeft():
	$"Openspace_Cam/Office/Door-Left".play("opening")
	$Openspace_Cam/Office/LeftDoorAudioStreamPlayer2D.play()
	await get_tree().create_timer(1).timeout
	$"Openspace_Cam/Office/Door-Left".play("closed")
	await get_tree().create_timer(0.5).timeout
	$"Openspace_Cam/Office/Door-Left".play("opening")
	await get_tree().create_timer(0.5).timeout
	$"Openspace_Cam/Office/Door-Left".play("open")
	#$Openspace_Cam/Office/LeftDoorCreakingAudioStreamPlayer2D.play()
	await get_tree().create_timer(9).timeout
	$"Openspace_Cam/Office/Door-Left".play("closed")

func _openDoorRight():
	$Openspace_Cam/Office/John.position.x = 100
	$"Openspace_Cam/Office/Door-Right".play("opening")
	$Openspace_Cam/Office/RightDoorAudioStreamPlayer2D.play()
	await get_tree().create_timer(1).timeout
	$"Openspace_Cam/Office/Door-Right".play("closed")
	await get_tree().create_timer(0.5).timeout
	$"Openspace_Cam/Office/Door-Right".play("opening")
	await get_tree().create_timer(0.5).timeout
	$"Openspace_Cam/Office/Door-Right".play("open")
	#$Openspace_Cam/Office/RightDoorCreakingAudioStreamPlayer2D.play()
	await get_tree().create_timer(2).timeout
	$Openspace_Cam/Office/John.visible = true
	await get_tree().create_timer(2).timeout
	$Openspace_Cam/Office/John.visible = false
	retourJohn = false
	await get_tree().create_timer(2).timeout
	$"Openspace_Cam/Office/Door-Right".play("closed")