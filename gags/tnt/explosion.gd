class_name Explosion

extends Area2D

var explosionMagnitude : float
var stunTime : float

func _ready():
	await get_tree().process_frame
	await get_tree().process_frame
	explode()

func explode():
	for body in get_overlapping_bodies():
		var explosionDirection = (body.position - position).normalized()
		if body is Player:
			body.velocity = explosionDirection * explosionMagnitude
			body.stun(stunTime)
		elif body is Gag:
			body.apply_force(explosionDirection * explosionMagnitude)
	$DespawnTimer.start()

func _on_DespawnTimer_timeout():
	queue_free()
