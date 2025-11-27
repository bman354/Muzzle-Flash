extends CharacterBody2D


const SPEED := 300.0
const FRICTION := 0.8

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
