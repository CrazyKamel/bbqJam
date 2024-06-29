extends StaticBody2D
var timer := Timer.new()

var sausage;

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.one_shot = true
	timer.wait_time = 1
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
	if ! body.cooking && body.state == 2:
		body.input_pickable = false
		timer.start()
		sausage = body


func _on_plate_area_2d_2_body_exited(body):
	body.input_pickable = true


func _on_timer_timeout():
	sausage.queue_free()
	queue_free()
