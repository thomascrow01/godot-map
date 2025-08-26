class_name Tile extends Node3D

# file created: 10-07-2025
# last edited: 10-07-2025

const placeholder_sprite: Texture2D = preload("res://icon.svg")
@export var characters: Array[Character]

@onready var fog: FogVolume = get_node_or_null("FogVolume") # fog used for fog of war
@onready var enviroment: Node3D = get_node_or_null("Enviroment") # may add something to not use this for hex tiles
@onready var collider: CollisionObject3D = get_node_or_null("MouseCollision")
@onready var screen_notifier: VisibleOnScreenNotifier3D = get_node_or_null("ScreenNotifier")
var collision: CollisionShape3D

@onready var sprite: Sprite2D = get_node_or_null("Sprite2D")
@onready var collider_2d: CollisionObject2D = get_node_or_null("Area2D")
@onready var screen_notifier_2d: VisibleOnScreenNotifier2D = get_node_or_null("VisibleOnScreenNotifier2D")

@export var terrain: Array[String] ## Used for deciding how tough it is to travel
@export var has_road: bool = false ## if the tile has a road or not

@export var explored: bool = false

var tile_resource: TileResource

func _init(data: TileResource) -> void:
	tile_resource = data

# https://www.youtube.com/watch?v=ItAvgeKB0Kk

func _ready() -> void:
	
	if !screen_notifier:
		screen_notifier = VisibleOnScreenNotifier3D.new()
		add_child(screen_notifier)
		screen_notifier.screen_entered.connect(_load_visuals)
		screen_notifier.screen_exited.connect(_unload_visuals)
		screen_notifier.aabb.size.x = 256.0
		screen_notifier.aabb.size.z = 256.0
	
	if !sprite:
		sprite = Sprite2D.new()
		add_child(sprite)
		sprite.position = Vector2(  float(tile_resource.location.x) * 128.0 , float(tile_resource.location.y) * 128.0 )
	
	if !screen_notifier_2d:
		screen_notifier_2d = VisibleOnScreenNotifier2D.new()
		sprite.add_child(screen_notifier_2d)
		screen_notifier_2d.screen_entered.connect(_load_visuals_2d)
		screen_notifier_2d.screen_exited.connect(_unload_sprite)
		
	
	if tile_resource and tile_resource.location:
		position = Vector3( float(tile_resource.location.x) * 128.0 ,0.0, float(tile_resource.location.y) * 128.0)
		
		name = str(tile_resource.location)
	if !fog:
		fog = preload("res://scenes/enviroment_prefabs/square_fog.tscn").instantiate()
		add_child(fog)
	if !enviroment:
		enviroment = MeshInstance3D.new()
		#if !tile_resource or !tile_resource.enviroment_link:
			#enviroment = preload("res://scenes/enviroment_prefabs/square_ground.tscn").instantiate()
		#elif tile_resource and tile_resource.enviroment_link:
			#enviroment = MeshInstance3D.new()
			#enviroment.mesh = load(tile_resource.enviroment_link)
		add_child(enviroment)
		
		#for terrain_element in terrain:
			#match terrain_element.to_lower():
				#"ocean":
					#enviroment.mesh.material.albedo_color = Color(0.0,0.0,1.0,1.0)
				#"forest":
					#enviroment.mesh.material.albedo_color = Color(0.0,1.0,0.0,1.0)
				#"mountain":
					#enviroment.mesh.material.albedo_color = Color.hex(0x88E788)
				#_:
					#enviroment.mesh.material.albedo_color = Color(1.0,1.0,1.0,1.0)



	if !collider:
		collider = Area3D.new()
		add_child(collider)
		
		collision = CollisionShape3D.new()
		collider.add_child(collision)

		#elif enviroment.get_child(0) is MeshInstance3D:
			#collision.shape = enviroment.get_child(0).mesh.create_convex_shape()
		var box_shape = BoxShape3D.new()
		box_shape.size.x = 128.0
		box_shape.size.z = 128.0
		collision.shape = box_shape
		
	if !collider_2d:
		
		collider_2d = Area2D.new()
		sprite.add_child(collider_2d)
		
		var collision_2d = CollisionShape2D.new()
		collider_2d.add_child(collision_2d)
		collision_2d.shape = RectangleShape2D.new()
		collision_2d.shape.size = Vector2(128.0,128.0)
	

			
	# TODO signal for mouse_entered, mouse_exited and input_event from collider
	collider.mouse_entered.connect(mouse_entered)
	collider_2d.mouse_entered.connect(mouse_entered)
	fog.visible = !explored

func explore(val: bool) -> void:
	explored = val
	fog.visible = !explored

func _unload_visuals() -> void:
	if fog:
		fog.visible = false
	if enviroment:
		#enviroment.queue_free.call_deferred()
		enviroment.mesh = null
	
func _load_visuals() -> void:
	if fog:
		fog.visible = !explored
	if !enviroment:
		if !tile_resource or !tile_resource.enviroment_link:
			enviroment = preload("res://scenes/enviroment_prefabs/square_ground.tscn").instantiate()
			tile_resource.enviroment_link = "res://scenes/enviroment_prefabs/square_ground.tres"
		elif tile_resource and tile_resource.enviroment_link:
			enviroment = MeshInstance3D.new()
			
			enviroment.mesh = ResourceLoader.load(tile_resource.enviroment_link)
			
		#if enviroment is MeshInstance3D and !collision:
			#collision.shape = enviroment.mesh.create_convex_shape()
				
		add_child.call_deferred(enviroment)
	else:
		#var task = WorkerThreadPool.add_task(_load_mesh)
		#WorkerThreadPool.wait_for_task_completion(task)
		_load_mesh()
		
func _load_mesh() -> void:
	if tile_resource.enviroment_link:
		enviroment.mesh = load(tile_resource.enviroment_link)
	else:
		pass
	
func _load_visuals_2d() -> void:
	if sprite:
		_load_sprite()
	else:
		sprite.texture = placeholder_sprite
		
func _unload_sprite() -> void:
	sprite.texture = null
		
func _load_sprite() -> void:
	#print(tile_resource.map_link)
	if tile_resource.map_link:
		sprite.texture = load(tile_resource.map_link)
	else:
		sprite.texture = placeholder_sprite
		pass

func mouse_entered() -> void:
	
	if get_parent().get_parent():
		print("mouse entered: " + name)
		get_parent().get_parent().get_node("Party").selected_tile = self
