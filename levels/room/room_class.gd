class_name Room

extends Area2D

signal player_entered_room(roomPosition : Vector2, roomExtents : Rect2)
signal update_gags(newGagResources)

@export var entranceVector : Vector2
@export var exitVector : Vector2
@export var isStartRoom : bool

var isPlayerInRoom : bool

func _on_body_entered(body):
	if isStartRoom:
		emit_signal("update_gags", get_parent().activeGagResources)
	if body is Player:
		if entranceVector == body.moveDirection:
			body.flip_direction()
			body.velocity.x = 0.0
		else:
			emit_signal("player_entered_room", global_position, $CollisionShape2D.shape.extents * scale)

func _input(_event):
	if Input.is_action_just_pressed("FORCE_UPDATE_CAMERA"):
		for body in get_overlapping_bodies():
			if body is Player:
				emit_signal("player_entered_room", global_position, $CollisionShape2D.shape.extents * scale)
