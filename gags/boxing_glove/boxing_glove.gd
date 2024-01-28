class_name BoxingGlove
extends Gag

@export var direction : Vector2
@export var strongHitMagnitude : float
@export var weakHitMagnitude : float
@export var stunTime : float

func _ready():
	$AnimationPlayer.current_animation = "0"

func _on_Slider_value_changed(value):
	$AnimationPlayer.current_animation = str(value)

func _on_body_entered(body):
	if body is Player:
		body.position = direction * $Slider.value * 32.0

func _on_StrongHurtBox_body_entered(body):
	if body is Player:
		body.velocity = direction * strongHitMagnitude
		body.stun(stunTime)
	elif body is Gag:
		body.apply_force(direction * strongHitMagnitude)

func _on_WeakHurtBox_body_entered(body):
	if body is Player:
		body.velocity = direction * strongHitMagnitude
		body.stun(stunTime)
	elif body is Gag:
		body.apply_force(direction * strongHitMagnitude)
