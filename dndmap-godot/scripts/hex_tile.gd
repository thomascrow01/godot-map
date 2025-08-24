class_name HexTile extends Tile

# file created: 11-06-2025
# last edited: 11-06-2025

var axial_coord: Vector2i
var neighbours: Array[HexTile] = []

func _init(value: Vector2i = Vector2i(0,0)):
	axial_coord = value
