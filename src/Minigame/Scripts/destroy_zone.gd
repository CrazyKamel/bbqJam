extends Area2D



func _on_body_entered(body):
	Global.minigameScore -=5
	body.queue_free()
