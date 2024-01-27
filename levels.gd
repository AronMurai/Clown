extends Node

@export var cameraPath : NodePath
@onready var camera : Camera = get_node(cameraPath) 

func _ready():
	for level in get_children():
		for room in level.rooms:
			room.player_entered_room.connect(camera.update_camera)
