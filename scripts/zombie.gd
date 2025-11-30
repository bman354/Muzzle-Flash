extends CharacterBody2D

const SPEED := 30.0



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

	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var obj = collision.get_collider()
		if obj.get_groups()[0] == "bullet":
			queue_free()
			obj.queue_free()
	
	

func pathfind() -> void:
	nav_agent.target_position = player.position



func _on_timer_timeout() -> void:
	pathfind()
