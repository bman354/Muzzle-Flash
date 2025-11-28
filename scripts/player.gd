extends CharacterBody2D


const SPEED := 30.0
const FRICTION := 0.5

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):

	if Input.is_action_pressed("move_right"):
		velocity.x += SPEED
	if Input.is_action_pressed("move_left"):
		velocity.x -= SPEED
	if Input.is_action_pressed("move_up"):
		velocity.y -= SPEED
	if Input.is_action_pressed("move_down"):
		velocity.y += SPEED
	
	
	
	velocity.normalized()
	

	move_and_slide()
	velocity.x *= FRICTION
	velocity.y *= FRICTION

	if(velocity.x < 0.1 and velocity.x > -0.1):
		velocity.x = 0.0
	if(velocity.y < 0.1 and velocity.y > -0.1):
		velocity.y = 0.0


	if(velocity.x != 0 or velocity.y != 0):
		anim.play("walk")
	else:
		anim.play("default")
