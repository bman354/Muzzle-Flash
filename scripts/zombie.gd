extends CharacterBody2D

const SPEED := 30.0

@export var player: Node2D
@onready var nav_agent := $NavigationAgent2D as NavigationAgent2D
@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	if player != null:
		pathfind()

func _physics_process(_delta: float) -> void:
	var dir =  to_local(nav_agent.target_position).normalized()	
	velocity = dir * SPEED
	move_and_slide()	
	if (velocity.x != 0.0 and velocity.y != 0.0):
		anim.play("walking")
	#print(nav_agent.target_position)


func pathfind() -> void:
	nav_agent.target_position = player.position
	#print("pathfind called")


func _on_timer_timeout() -> void:
	pathfind()
	#print("timer finished")
