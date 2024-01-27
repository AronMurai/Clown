class_name Checkpoint

extends Area2D

func _on_body_entered(body):
	if body is Player:
		body.set_checkpoint(position)
