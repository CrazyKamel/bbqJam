extends Node2D

@export var collegue: PackedScene
var timer := Timer.new()

func _spawnCollegue():
	print("Created collegue")
	var collegue1 = collegue.instantiate()
	collegue1.position = Vector2(randf_range(0.0,1920.0), randf_range(0.0, 1080.0))
	add_child(collegue1)
	timer.wait_time = randi_range(1, 5)
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
	pass
	#randomize()
	#$Sprite.visible = false
	#var t = randi_range(5,20)
	#await(get_tree().create_timer(t))
	#$Sprite.visible = true
