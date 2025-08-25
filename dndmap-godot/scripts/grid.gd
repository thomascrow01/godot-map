class_name Grid extends Node3D

# file created: 10-07-2025
# last edited: 10-07-2025

@export var tiles: Dictionary[Vector2i, Tile]
@export var data: GridData

#HARD CODE TEST HERE
func _ready() -> void:
	if data:
		if data.x_range_lower >= data.x_range_upper or data.y_range_lower >= data.y_range_upper:
			push_error("Range is fucked up")
			return
		for x in range(data.x_range_lower, data.x_range_upper):
			for y in range(data.y_range_lower, data.y_range_upper):
				if tiles.has(Vector2i(x,y)):
					if !tiles[Vector2i(x,y)].enviroment:
						pass
					pass
				else:
					var new_resource: TileResource
					
					new_resource = TileResource.new()
					if ResourceLoader.exists("res://assets/models/minecraft_world_of_regions/" + str(x) + "_" + str(y) + ".obj"):
						new_resource.enviroment_link = "res://assets/models/minecraft_world_of_regions/" + str(x) + "_" + str(y) + ".obj"

					if ResourceLoader.exists("res://assets/sprites/minecraft_world_of_regions/" + str(x) + "_" + str(y) + ".png"):
						new_resource.map_link = "res://assets/sprites/minecraft_world_of_regions/" + str(x) + "_" + str(y) + ".png"
					
					new_resource.location = Vector2i(x,y)
					tiles[Vector2i(x,y)] = Tile.new(new_resource)
					add_child.call_deferred(tiles[Vector2i(x,y)])
						
