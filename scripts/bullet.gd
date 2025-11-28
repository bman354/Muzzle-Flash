extends CharacterBody2D

@export var SPEED := 500.0


func _process(delta):
	move_and_slide()
