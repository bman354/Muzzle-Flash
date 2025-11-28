extends CharacterBody2D


enum DirFacing {
	LEFT = 1,
	RIGHT = 0
}

const SPEED := 30.0
const FRICTION := 0.5
var FACING = DirFacing.RIGHT


@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):

	if Input.is_action_pressed("move_right"):
		FACING = DirFacing.RIGHT
		velocity.x += SPEED
	if Input.is_action_pressed("move_left"):
		FACING = DirFacing.LEFT
		velocity.x -= SPEED
	if Input.is_action_pressed("move_up"):
		velocity.y -= SPEED
	if Input.is_action_pressed("move_down"):
		velocity.y += SPEED
	
	if Input.is_action_just_pressed("player_shoot"):
		shoot()
		pass
	
	velocity.normalized()

	move_and_slide()
	velocity.x *= FRICTION
	velocity.y *= FRICTION

	if(velocity.x < 0.1 and velocity.x > -0.1):
		velocity.x = 0.0
	if(velocity.y < 0.1 and velocity.y > -0.1):
		velocity.y = 0.0

	if(anim.animation != "shoot"):
		if(velocity.x != 0 or velocity.y != 0):
			anim.play("walk")
		else:
			anim.play("default")
	
	anim.flip_h = FACING
		
		
		
func shoot():
	anim.play("shoot")
	
func _on_animated_sprite_2d_animation_finished():
	if anim.animation == "shoot":
		anim.play("default")
