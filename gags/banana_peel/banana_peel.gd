extends Gag

@export var slipDirection : Vector2
@export var slipMagnitude : float
@export var stunTime : float

func slip(body):
	if body is Player:
		body.velocity = Vector2(body.moveDirection.x * slipDirection.x, slipDirection.y) * slipMagnitude
		#Vector2(moveDirection.x * $CollisionShape2D.shape.size.x, $CollisionShape2D.shape.size.y) / 1.9  
		body.stun(stunTime)
		discard()
	elif body is Gag:
		body.apply_impulse(slipDirection * slipMagnitude)
		discard()

func _on_body_entered(body : Node2D):
	slip(body)
