extends Control

@onready var shell1 := $HBoxContainer/Shell1
@onready var shell2 := $HBoxContainer/Shell2

const full_shell_texture = preload("res://assets/full_shell.png")
const empty_shell_texture = preload("res://assets/empty_shell.png")

@export var shell_scale = Vector2(1,1)



func _ready():
	_on_player_ammo_changed(2)
	shell1.scale = shell_scale
	shell2.scale = shell_scale
	

func _on_player_ammo_changed(amount: int):
	
	shell1.scale = shell_scale
	shell2.scale = shell_scale
	
	match amount:
		0:
			shell1.texture = empty_shell_texture
			shell2.texture = empty_shell_texture
		1:
			shell1.texture = full_shell_texture
			shell2.texture = empty_shell_texture
		2:
			shell1.texture = full_shell_texture
			shell2.texture = full_shell_texture
