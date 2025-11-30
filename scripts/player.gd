extends CharacterBody2D


enum DirFacing {
	LEFT = 1,
	RIGHT = 0
}

@export var max_zoom: Vector2 = Vector2(2.0,2.0)

@export var SPEED := 3.0
@export var FRICTION := 0.5

@export var bullet_scene: PackedScene

var FACING = DirFacing.RIGHT
var can_fire := true

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var camera: Camera2D = $Camera2D


func _ready():
	change_zoom(max_zoom.x)
	add_to_group("player")
	anim.play("default")
	

func _physics_process(delta):

	var input_dir = Vector2.ZERO

	if Input.is_action_pressed("move_right"):
		FACING = DirFacing.RIGHT
		input_dir.x += 1
	if Input.is_action_pressed("move_left"):
		FACING = DirFacing.LEFT
		input_dir.x -= 1
	if Input.is_action_pressed("move_down"):
		input_dir.y += 1
	if Input.is_action_pressed("move_up"):
		input_dir.y -= 1

	input_dir = input_dir.normalized()  # ensures diagonal movement isn't faster
	velocity = input_dir * SPEED
		
	
	if Input.is_action_just_pressed("player_shoot"):
		shoot()

	if Input.is_action_just_pressed("scroll_down"):
		change_zoom(-0.1)
	if Input.is_action_just_pressed("scroll_up"):
		change_zoom(0.1)

	
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
		
	
func _on_timer_timeout():
	if not can_fire:
		can_fire = true
		
		
func shoot():
	
	if bullet_scene and can_fire:
		anim.play("shoot")
		var mouse_dir = (get_global_mouse_position() - global_position).normalized()

		var pellets := 5
		var spread_degrees := 8.0 

		for i in range(pellets):
			var bullet = bullet_scene.instantiate()
			bullet.global_position = global_position

			var angle_offset = deg_to_rad(randf_range(-spread_degrees, spread_degrees))
			var shot_dir = mouse_dir.rotated(angle_offset)

			bullet.velocity = shot_dir * bullet.SPEED
			get_parent().add_child(bullet)
		can_fire = false
		$FiringTimer.start()
	
	
func _on_animated_sprite_2d_animation_finished():
	if anim.animation == "shoot":
		anim.play("default")

func change_zoom(delta_zoom: float):
	var curzoom = camera.zoom
	curzoom.x = clamp(curzoom.x + delta_zoom, max_zoom.x, 10.0)
	curzoom.y = clamp(curzoom.y + delta_zoom, max_zoom.y, 10.0)
	camera.zoom = curzoom
