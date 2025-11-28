extends CharacterBody2D


enum DirFacing {
	LEFT = 1,
	RIGHT = 0
}

@export var SPEED := 30.0
@export var FRICTION := 0.5

@export var bullet_scene: PackedScene

var FACING = DirFacing.RIGHT


@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var camera: Camera2D = $Camera2D

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

	if Input.is_action_just_pressed("scroll_down"):
		var curzoom = camera.get_zoom()
		curzoom.x -= 0.1
		curzoom.y -= 0.1
		camera.set_zoom(curzoom)
		
	if Input.is_action_just_pressed("scroll_up"):
		var curzoom = camera.get_zoom()
		curzoom.x += 0.1
		curzoom.y += 0.1
		camera.set_zoom(curzoom)
	
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
	
	if bullet_scene:
		var bullet = bullet_scene.instantiate()
		bullet.position = global_position
		var mouse_dir = (get_global_mouse_position() - global_position).normalized()
		
		bullet.velocity = mouse_dir * bullet.SPEED
		
		get_parent().add_child(bullet)
	
	
func _on_animated_sprite_2d_animation_finished():
	if anim.animation == "shoot":
		anim.play("default")
