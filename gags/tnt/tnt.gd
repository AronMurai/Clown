extends Gag

@export var countdownTimer : float
@export var explosionMagnitude : float
@export var stunTime : float
@export var explosionResource : PackedScene

func _ready():
	$ExplosionTimer.wait_time = countdownTimer
	$AnimatedSprite.speed_scale = countdownTimer * 3
	$ExplosionTimer.start()

func _on_ExplosionTimer_timeout():
	explode()

func explode():
	var explosion = explosionResource.instantiate()
	explosion.stunTime = stunTime
	explosion.explosionMagnitude = explosionMagnitude
	explosion.position = position
	get_parent().add_child(explosion)
	queue_free()
