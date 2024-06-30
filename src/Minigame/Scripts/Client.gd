extends StaticBody2D
var timer := Timer.new()

var sausage;

@onready var emote_bubble = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	emote_bubble.animation = "default"
	timer.one_shot = true
	timer.wait_time = 0.6
	timer.connect("timeout", _on_timer_timeout)
	add_child(timer)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.x > 0:
		if ! $RayCast2D.is_colliding():
			position.x -= 100*delta
	pass


func _on_plate_area_2d_2_body_entered(body):
	if ! body.cooking:
		body.input_pickable = false
		$PointSoundPlayer.play()
		anim_play(body.state)
		timer.start()
		sausage = body

func _on_plate_area_2d_2_body_exited(body):
	body.input_pickable = true

func anim_play(state):
	match state:
		0:
			emote_bubble.animation = "angry"
		1:
			emote_bubble.animation = "happy"
		2:
			emote_bubble.animation = "ok"
		3:
			emote_bubble.animation = "angry"

func _on_timer_timeout():
	if sausage != null:
		sausage.queue_free()
		match sausage.state:
			0:
				Global.minigameScore -=10
				emote_bubble.animation = "angry"
			1:
				Global.minigameScore +=15
				emote_bubble.animation = "happy"
			2:
				Global.minigameScore +=10
				emote_bubble.animation = "ok"
			3:
				Global.minigameScore -= 20
				emote_bubble.animation = "angry"
	queue_free()
