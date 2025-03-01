extends Node2D

var held_object = false
var timer := Timer.new()

var canSpawn = true
var excelVisible = true

@export var sausage : PackedScene
@export var excel_sprite: Sprite2D

var client = preload("res://src/Minigame/Scenes/Client.tscn")

func set_excel_visibility(vis):
	excel_sprite.visible = vis
	excelVisible = vis
	pass

func _process(delta):
	$Label.text = "Score : " + str(Global.minigameScore)

func _ready():
	for node in get_tree().get_nodes_in_group("pickable"):
		node.clicked.connect(_on_pickable_clicked)
	timer.one_shot = false
	timer.wait_time = randi_range(1, 5) 
	timer.connect("timeout", _spawnClient)
	add_child(timer)
	timer.start()

func connect_to_pickable(object):
	object.clicked.connect(_on_pickable_clicked)

func disconnect_from_pickable(object):
	object.clicked.disconnect(_on_pickable_clicked)

func _on_pickable_clicked(object):
	if !held_object:
		object.pickup()
		held_object = object

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if held_object and !event.pressed:
			if held_object != null:
				held_object.drop(Input.get_last_mouse_velocity())
			held_object = null

func _on_sausage_spawner_pressed():
	if !excelVisible && Global.minigameView:
		var food_item = sausage.instantiate()
		food_item.position = $Control/SpawnPosition.position
		$Control/SausageSpawner/AudioStreamPlayer2D.play()
		add_child(food_item)

func _spawnClient():
	print(canSpawn)
	if canSpawn:
		var client1 = client.instantiate()
		client1.position = Vector2(randi_range(1000, 1100),randi_range(210, 240))
		add_child(client1)
		timer.wait_time = randi_range(3, 8)
	pass


func _on_area_2d_area_entered(area):
	canSpawn = false


func _on_area_2d_area_exited(area):
	canSpawn = true
