extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_yes_button_pressed():
	Global.goto_scene("res://src/main.tscn")


func _on_no_button_pressed():
	get_parent().subscribeCancelQuit();
	self.queue_free()
