extends TextureRect

@export var drawings : Array[Texture]
var currentDrawing = 0

func _ready():
	texture = drawings[0]
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				currentDrawing += 1
				if currentDrawing < 3:
					texture = drawings[currentDrawing]
				else:
					get_tree().change_scene_to_file("res://title/title_screen.tscn")
