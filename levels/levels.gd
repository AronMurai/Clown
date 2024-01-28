extends Node

@export var camera : Camera
@export var gagSpawner : GagSpawner 

func _ready():
	for level in get_children():
		for room in level.rooms:
			room.player_entered_room.connect(camera.update_camera)
			room.update_gags.connect(gagSpawner.update_buttons)
