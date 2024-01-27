class_name Camera
extends Camera2D

@export var windowSize : Vector2

func update_camera(newCameraPosition : Vector2, newFrameArea : Vector2):
	zoom = 0.5 * windowSize / newFrameArea
	position = newCameraPosition
