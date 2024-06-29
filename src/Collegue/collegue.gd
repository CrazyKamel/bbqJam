extends Node2D

@export var speed = 100

var norme
var vecteur_direction
var position_porte = Vector2(300, 150)
var position_visee = position_porte
var position_side_desk = Vector2(700, 800)
var starting_pos
var sens # 0 = gauche ; 1 = droite
var velocity
var frozen = false
var selfSubType

var aller = true

enum Type {LEFT, RIGHT, BOSS}
enum subType {REPORT, FRIEND, CLASSIC}

var probaSpawnTypes = {"right":0.35,"left": 0.9}
var probaSubTypes = {"friend":0.35,"classic": 0.9}


var startPosses = {"rightStartPos": Vector2(1600,150), "leftStartPos": Vector2(150, 150), "bossStartPos": Vector2(960, 900)}

var selfType

var timer := Timer.new()

func friend_coming():
	position_visee = position_side_desk
	frozen = false
	pass

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
	if selfSubType == subType.FRIEND:
		if aller == false && position_visee == position_porte:
			position_visee = startPosses["rightStartPos"] if Global.coinflip() else startPosses["leftStartPos"]
			frozen = false
		elif aller && position_visee == position_porte:
			position_visee = position_side_desk
			frozen = false
		else:
			await get_tree().create_timer(15).timeout
			position_visee = position_porte
			frozen = false
	else:
		if !aller:
			print("Collegue killed")
			get_parent().collegueDiedRIP()
			queue_free()
		else:
			await get_tree().create_timer(2).timeout
	aller = false
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	var r = randf()
	if r >= probaSpawnTypes["left"]: # BOSS (0.9-1)
		selfType = Type.BOSS # boss
		starting_pos = startPosses["bossStartPos"]
		print("Spawned boss")
		pass
	elif r < probaSpawnTypes["right"]: # left (0-0.35)
		selfType = Type.LEFT # left
		starting_pos = startPosses["leftStartPos"]
		print("Spawned left")
		pass
	else: # right (0.35-0.9)
		selfType = Type.RIGHT # right
		starting_pos = startPosses["rightStartPos"]
		print("Spawned right")
		pass
		
	position = starting_pos
	print(get_viewport_rect().size)
	
	if selfType == 0 || selfType == 1:
		r = randf()
		if r >= probaSubTypes["classic"]:
			selfSubType = subType.REPORT
		elif r < probaSubTypes["friend"]:
			selfSubType = subType.FRIEND
			print("FRIEND")
		else:
			selfSubType = subType.CLASSIC
			
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	vecteur_direction = calc_direction()
	if not frozen:
		velocity = vecteur_direction * speed
		self.position += velocity*delta
	#print(position.x)
	if abs((position_visee - self.position).x) < 50 and abs((position_visee - self.position).y) < 50:
		got_to_dest()
	pass
