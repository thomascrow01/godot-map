class_name HexGrid extends Grid

# file created: 11-06-2025
# last edited: 16-06-2025

## Grid that holds multiple hexes

@export var size: int = 1 ## how many hex layers the grid will have
@export var hex_scene: PackedScene ## packed scene to use as the hexes
var hexes: Dictionary[Vector2i, HexTile]

@export var width: float = 1.0 ## width of the hex
@export var height: float = 1.0 ## height of the hex

var axial_direction_vectors = [Vector2i(1,0), #right
Vector2i(1,-1), #top right
Vector2i(0,-1), #top left
Vector2i(-1,0), #left
Vector2i(-1,1), #bottom left
Vector2i(0,1)] #bottom right


func _ready() -> void:
	set_up_grid()

func set_up_grid() -> void:
	if size < 1: return
	
	var direction: int = 2
	var count: int = 0
	var previous_coord: Vector3
	
	#initial hex
	var new_hex = hex_scene.instantiate() # cant seem to get this as a HexTile
	add_child(new_hex)
	#new_hex.axial_coord = Vector2i(0,0)
	hexes.get_or_add(Vector2i(0,0), new_hex)
	new_hex.position = Vector3(0.0,0.0,0.0) # may need to swap all global pos for normal pos
	previous_coord = new_hex.position
	
	for i in range(size):
		
		#start at right hex in the layer
		var coord: Vector2i = Vector2i(i, -i)
		
		new_hex = hex_scene.instantiate()
		add_child(new_hex)
		
		match axial_direction_vectors[direction]: # find better way to do this later
			Vector2i(1,0): #right
				new_hex.position = previous_coord + Vector3(width, 0.0, 0.0)
			Vector2i(1,-1): #top right
				new_hex.position = previous_coord + Vector3(width * 0.5, 0.0, height * (3.0/2.0))
			Vector2i(0,-1): #top left
				new_hex.position = previous_coord + Vector3(-width * 0.5, 0.0, height * (3.0/2.0))
			Vector2i(-1,0): #left
				new_hex.position = previous_coord + Vector3(-width, 0.0, 0.0)
			Vector2i(-1,1): #bottom left
				new_hex.position = previous_coord + Vector3(-width * 0.5, 0.0, -height * (3.0/2.0))
			Vector2i(0,1): #bottom right
				new_hex.position = previous_coord + Vector3(width * 0.5, 0.0, -height * (3.0/2.0))
			_:
				new_hex.position = previous_coord
				push_warning(name + " ended up having default use case used being: " + str(direction))
					
		previous_coord = new_hex.position 
		
		#new_hex.axial_coord = coord
		hexes.get_or_add(coord, new_hex)
		#var q: Vector3 = Vector3(0,0,float(coord.y))
		#var r: Vector3 = Vector3(0,0,0) # top left to bottom right
		#var s: Vector3 = Vector3(0,0,0) # bottom left to top right # s = -coord.x-coord.y
		#new_hex.position = Vector3(float(coord.x),0,float(coord.y)) # TODO actually make these go to correct positions
		#var previous_coord: Vector2i = coord
		
		for j in range(i*6 - 1):
			coord += axial_direction_vectors[direction]
			
			new_hex = hex_scene.instantiate()
			add_child(new_hex)
			#new_hex.axial_coord = coord
			hexes.get_or_add(coord, new_hex)
			#new_hex.position = Vector3(float(coord.x),0,float(coord.y)) # * multipler # to add later
			print(count)
			print(axial_direction_vectors[direction])
			
			match axial_direction_vectors[direction]: # find better way to do this later
				Vector2i(1,0): #right
					new_hex.position = previous_coord + Vector3(width, 0.0, 0.0)
				Vector2i(1,-1): #top right
					new_hex.position = previous_coord + Vector3(width * 0.5, 0.0, height * (3.0/2.0))
				Vector2i(0,-1): #top left
					new_hex.position = previous_coord + Vector3(-width * 0.5, 0.0, height * (3.0/2.0))
				Vector2i(-1,0): #left
					new_hex.position = previous_coord + Vector3(-width, 0.0, 0.0)
				Vector2i(-1,1): #bottom left
					new_hex.position = previous_coord + Vector3(-width * 0.5, 0.0, -height * (3.0/2.0))
				Vector2i(0,1): #bottom right
					new_hex.position = previous_coord + Vector3(width * 0.5, 0.0, -height * (3.0/2.0))
				_:
					new_hex.position = previous_coord
					push_warning(name + " ended up having default use case used being: " + str(direction))
					
					
			previous_coord = new_hex.position 

			count += 1
			if count == i:
				count = 0
				direction = clampi(direction + 1, 0, axial_direction_vectors.size() - 1)

func cube_to_axial(cube: Vector3i):
	var q = cube.x
	var r = cube.y
	return Vector2i(q, r)

func axial_to_cube(hex: Vector2i):
	var q = hex.x
	var r = hex.y
	var s = -q-r
	return Vector3i(q, r, s)
