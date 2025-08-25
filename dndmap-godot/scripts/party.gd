class_name Party extends Node3D


@export var location: Tile
@export var data: PartyData
@export var time_system: TimeSystem

@onready var grid: Grid = get_owner().get_node("Grid")
var selected_tile: Tile

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if data and data.location:
		location = grid.tiles[data.location]
		#global_position = Vector3(location.global_position.x, 0.0, location.global_position.z)
		global_position = Vector3(128.0 * float(data.location.x), global_position.y, 128.0 * float(data.location.y))
	get_owner().get_node("CameraPivot").global_position = global_position
	get_owner().get_node("CameraPivot").cam2d.global_position = Vector2(data.location) * 128.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse1") and selected_tile:

		print(location.tile_resource.location.distance_to(selected_tile.tile_resource.location))
		if selected_tile != location and location.tile_resource.location.distance_to(selected_tile.tile_resource.location) <= 1.0:
			location = selected_tile
			global_position = Vector3(128.0 * float(location.tile_resource.location.x), global_position.y, 128.0 * float(location.tile_resource.location.y))
			
			if !data.explored.has(selected_tile.tile_resource.location):
				data.explored.append(selected_tile.tile_resource.location)
				selected_tile.explore(true)
