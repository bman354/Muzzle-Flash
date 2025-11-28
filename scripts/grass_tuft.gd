extends TileMap

@export var grass_tile: int = 0
@export var density: float = 0.01

func _ready():
	var used_cells = 0
	for x in range(200):
		for y in range(200):
			if randf() < density:
				set_cell(0,Vector2i(x,y), grass_tile)
