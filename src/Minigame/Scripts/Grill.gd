extends Area2D

func _on_body_entered(body):
	body.cooking = true

func _on_body_exited(body):
	body.cooking = false
