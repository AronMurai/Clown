extends CharacterBody2D

class_name Player

@export var SPEED : float
@export var ACCELERATION_DEFAULT : float
@export var ACCELERATION_AIR : float

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var acceleration : float
var moveDirection : Vector2
var stunned : bool

func _ready():
	stunned = false
	moveDirection = Vector2.RIGHT

func _physics_process(delta):
	if is_on_floor():
		$AnimatedSprite2D.play()
		acceleration = ACCELERATION_DEFAULT
	else:
		$AnimatedSprite2D.pause()
		acceleration = ACCELERATION_AIR

	if $FrontRayCast2D.is_colliding():
		flip_direction()
	if is_on_floor() and not $GroundRayCast2D.is_colliding():
		flip_direction()
	
	$FrontRayCast2D.target_position = moveDirection * $CollisionShape2D.shape.size.x/1.9
	$GroundRayCast2D.target_position = Vector2(moveDirection.x * $CollisionShape2D.shape.size.x, $CollisionShape2D.shape.size.y) / 1.9  
	
	if not stunned:
		velocity = velocity.lerp(moveDirection * SPEED, acceleration * delta)
	else:
		velocity = velocity.lerp(Vector2.ZERO, acceleration * delta)
		if is_on_floor():
			if $StunTimer.is_stopped():
				$StunTimer.start()
		else:
			$StunTimer.stop()
	
	velocity.y += gravity * delta
	move_and_slide()

func flip_direction():
	moveDirection = moveDirection * -1
	$AnimatedSprite2D.flip_h = not $AnimatedSprite2D.flip_h

func stun(timeStunned : float):
	stunned = true
	$AnimatedSprite2D.pause()
	$StunTimer.wait_time = timeStunned

func _on_StunTimer_timeout():
	stunned = false
