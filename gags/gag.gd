class_name Gag
extends RigidBody2D

const popUpHeight = 30.0
const animationLength = 0.5
@export var gagResource : GagResource

func discard():
	var tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 0.0), animationLength)
	tween.tween_property(self, "rotation", 270, animationLength)
	tween.tween_property(self, "position", position + Vector2(0, popUpHeight), animationLength)
	tween.set_parallel(false)
	tween.tween_callback(self.queue_free)
