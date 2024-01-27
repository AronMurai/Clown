class_name Room

extends Area2D

signal player_entered_room(roomPosition : Vector2, roomExtents : Rect2)

func _on_body_entered(body):
	if body is Player:
		emit_signal("player_entered_room", position, $CollisionShape2D.shape.extents * scale)
