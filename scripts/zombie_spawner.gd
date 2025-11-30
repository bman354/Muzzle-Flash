extends Node

## Seconds between zombie spawn rate at the start of game
@export var spawnrate := 0.5

## Number of spawns before we increase spawnrate TODO
@export var zombie_spawnrate_increase_count := 5




var zombies_spawned_this_round := 0
var spawn_now := false

@export var zombie_scene: PackedScene

@onready var timer := $SpawnTimer
@onready var player = $"../Player"



func _ready():
	if timer.is_stopped():
		timer.start(spawnrate)


func _on_spawn_timer_timeout():
	if not spawn_now:
		spawn_now = true

func _process(delta):
	
	if spawn_now:
		
		var zombie = zombie_scene.instantiate()
		
		zombie.global_position = get_random_position_to_player()
		
		add_child(zombie)
		spawn_now = false
		zombies_spawned_this_round += 1
		
		

func get_random_position_to_player() -> Vector2:
	const SAFERANGE := 500.0
	var playerPos = player.position
	var angle = randf() * PI * 2
	
	return playerPos + Vector2(cos(angle), sin(angle)) * SAFERANGE
