extends CharacterBody2D

@export var SPEED := 500.0

func _ready():
	add_to_group("bullet")

func _physics_process(delta):
	move_and_collide(velocity * delta)
	
