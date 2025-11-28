extends TileMapLayer

@export var source_id: int = 1                       
@export var atlas_coords: Vector2i = Vector2i(22,55)
@export var alternative: int = 0                      

@export var map_width:int = 2000
@export var map_height:int = 2000
@export var spawn_chance: float = 0.05

func _ready():
	randomize()
	generate_grass()

func generate_grass():
	for x in range(map_width):
		for y in range(map_height):
			if randf() < spawn_chance:
				set_cell(Vector2i(x,y), source_id, atlas_coords)
