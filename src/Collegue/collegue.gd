extends Node2D

@export var speed = 100

var norme
var vecteur_direction
var position_visee = Vector2(960, 150)
var starting_pos
var sens # 0 = gauche ; 1 = droite
var velocity
var frozen = false

enum Type {SNEAKY, LAZY, BOSS}
var probaSpawnTypes = {"lazy":0.35,"sneaky": 0.9}
var startPosses = {"lazyStartPos": Vector2(50,150), "sneakyStartPos": Vector2(1600, 150), "bossStartPos": Vector2(960, 900)}

var selfType

var timer := Timer.new()

func calc_direction():
	norme = (position_visee - self.position).length()
	vecteur_direction = (position_visee - position)/norme
	if vecteur_direction.x>0:
		sens=1
	else:
		sens=0
	return vecteur_direction

func got_to_dest():
	frozen = true
	await get_tree().create_timer(2).timeout
	print("Collegue killed")
	get_parent().collegueDiedRIP()
	queue_free()
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var r = randf()
	if r >= probaSpawnTypes["sneaky"]: # BOSS (0.9-1)
		selfType = 2 # boss
		starting_pos = startPosses["bossStartPos"]
		print("Spawned boss")
		pass
	elif r < probaSpawnTypes["lazy"]: # SNEAKY (0-0.35)
		selfType = 1 # sneaky
		starting_pos = startPosses["sneakyStartPos"]
		print("Spawned sneaky")
		pass
	else: # LAZY (0.35-0.9)
		selfType = 0 # lazy
		starting_pos = startPosses["lazyStartPos"]
		print("Spawned lazy")
		pass
		
	position = starting_pos
	print(get_viewport_rect().size)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	vecteur_direction = calc_direction()
	if not frozen:
		velocity = vecteur_direction * speed
		self.position += velocity*delta
	#print(position.x)
	if abs((position_visee - self.position).x) < 100 and abs((position_visee - self.position).y) < 100:
		got_to_dest()
	pass
