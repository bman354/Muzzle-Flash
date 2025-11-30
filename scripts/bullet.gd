extends Area2D

@export var SPEED := 500.0
var velocity := Vector2.ZERO


func _ready():
	add_to_group("bullet")

func _physics_process(delta):
	position += velocity * delta
	

func _on_body_entered(body):
	if body.is_in_group("zombie"):
		body.queue_free()
		queue_free()
