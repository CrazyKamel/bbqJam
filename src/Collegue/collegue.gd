extends Node2D

@export var speed = 100

var norme
var vecteur_direction
var position_porte = Vector2(750, 575)
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


var startPosses = {"rightStartPos": Vector2(1600,575), "leftStartPos": Vector2(150, 575), "bossStartPos": Vector2(960, 900)}

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
		if aller: # Aller
			if position_visee == position_porte: # Arrivé à la porte (aller)
				$Sprite2D.z_index = 0
				print("Arrivée à la porte, on repart dans 1s")
				position_visee = position_side_desk
				await get_tree().create_timer(1).timeout
				frozen = false
			elif position_visee == position_side_desk: # Arrivé au bureau
				$Sprite2D.z_index = 0
				print("Arrivée au bureau, on repart dans 15s")
				aller = false
				position_visee = position_porte
				await get_tree().create_timer(15).timeout
				print("Départ vers la porte")
				frozen = false
				pass
		else: # Retour
			if position_visee == position_porte: # Arrivé à la porte (retour)
				$Sprite2D.z_index = -1
				print("Arrivée à la porte (retour)")
				position_visee = startPosses["rightStartPos"] if Global.coinflip() else startPosses["leftStartPos"]
				print("Départ vers la sortie : ")
				print(position_visee)
				frozen = false
			else: # Arrivé au bout
				print("Arrivée au bout, on le bute ce chien")
				get_parent().collegueDiedRIP()
				queue_free()
	else:
		if aller:
			print("Arrivée à la porte, départ dans 2s")
			position_visee = startPosses["rightStartPos"] if Global.coinflip() else startPosses["leftStartPos"]
			await get_tree().create_timer(2).timeout
			print("Départ vers la sortie : ")
			print(position_visee)
			aller = false
			frozen = false
		else:
			print("Collegue killed")
			get_parent().collegueDiedRIP()
			queue_free()
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
