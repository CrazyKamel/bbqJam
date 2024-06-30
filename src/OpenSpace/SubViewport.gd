extends SubViewport

func _ready():
	world_2d = get_viewport().world_2d

### The camera this viewport replicates.
#@export var view_camera: Camera2D:
	#get: return _view_camera
	#set(value):
		#_view_camera = value
		#if _view_camera and camera:
			## These properties are only copied here, since I don't plan on changing them at runtime.
			## If you plan on changing more properties, add them here (only updates when you set view_camera),
			## or add them to _process() to update every frame.
			#camera.projection = _view_camera.projection
			#camera.size = _view_camera.size
			## Copy any other properties you need...
#
#@onready var camera: Camera2D = $Camera2D
#
#var _view_camera: Camera2D
#
#func _process(_delta: float) -> void:
	#if view_camera and camera:
		## Update any properties to copy the camera exactly.
		## I don't plan on changing anything put the transform at runtime,
		## but if you have more camera properties that would change at runtime, add them below.
		#camera.global_transform = view_camera.global_transform
