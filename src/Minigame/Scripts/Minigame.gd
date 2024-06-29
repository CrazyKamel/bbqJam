extends Node2D

var held_object = false

@export var sausage : PackedScene

func _ready():
	for node in get_tree().get_nodes_in_group("pickable"):
		node.clicked.connect(_on_pickable_clicked)

func connect_to_pickable(object):
	object.clicked.connect(_on_pickable_clicked)

func _on_pickable_clicked(object):
	print("Un truc")
	if !held_object:
		object.pickup()
		held_object = object

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if held_object and !event.pressed:
			held_object.drop(Input.get_last_mouse_velocity())
			held_object = null

func _on_sausage_spawner_pressed():
	var food_item = sausage.instantiate()
	food_item.position = $Control/SpawnPosition.position
	add_child(food_item)