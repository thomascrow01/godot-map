class_name GridData extends Resource

# file created: 10-07-2025
# last edited: 10-07-2025

@export_category("Generate ranges")
@export var x_range_lower: int
@export var x_range_upper: int
@export var y_range_lower: int
@export var y_range_upper: int

@export var tiles: Dictionary[Vector2i, TileResource]
@export var default_terrain: String
