extends CharacterBody2D

const SPEED := 30.0

enum DirFacing {
	LEFT = 1,
	RIGHT = 0
}
var FACING = DirFacing.RIGHT


@export var player: Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	add_to_group("zombie")
	player = get_tree().get_first_node_in_group("player")
	
	if player:
		pathfind()

func _physics_process(delta: float) -> void:
	var dir =  to_local(nav_agent.target_position).normalized()	
	velocity = dir * SPEED
		
	if (velocity.x != 0.0 and velocity.y != 0.0):
		anim.play("walking")

	if(velocity.x > 0):
		FACING = DirFacing.RIGHT
	if(velocity.x < 0):
		FACING = DirFacing.LEFT

	anim.flip_h = FACING
	move_and_collide(velocity * delta)
		
	

func pathfind() -> void:
	nav_agent.target_position = player.position



func _on_timer_timeout() -> void:
	pathfind()
