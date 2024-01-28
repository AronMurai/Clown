class_name Camera
extends Camera2D

@export var windowSize : Vector2

func update_camera(newCameraPosition : Vector2, newFrameArea : Vector2):
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "position", newCameraPosition, 1)
	tween.tween_property(self, "zoom", 0.5 * windowSize / newFrameArea, 1)
