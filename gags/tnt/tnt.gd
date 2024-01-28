extends Gag

@export var explosionMagnitude : float
@export var stunTime : float
@export var explosionResource : PackedScene

func explode():
	var explosion = explosionResource.instantiate()
	explosion.stunTime = stunTime
	explosion.explosionMagnitude = explosionMagnitude
	explosion.position = position
	get_parent().add_child(explosion)
	queue_free()

func ignite():
	$Sprite2D.texture.region = Rect2(32.0, 64.0, 32.0, 32.0)
	$ExplosionTimer.start()

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				ignite()

func _on_ExplosionTimer_timeout():
	explode()
