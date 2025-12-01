extends Control

@onready var shell1 := $HBoxContainer/Shell1
@onready var shell2 := $HBoxContainer/Shell2

const full_shell_texture = preload("res://assets/full_shell.png")
const empty_shell_texture = preload("res://assets/empty_shell.png")

func _ready():
	_on_player_ammo_changed(2)

func _on_player_ammo_changed(amount: int):
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
