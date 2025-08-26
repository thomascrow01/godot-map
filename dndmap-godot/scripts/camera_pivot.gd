extends Node3D

#created: 10.08.2025

@onready var cam2d: Camera2D = get_node_or_null("Camera2D")
@onready var cam3d: Camera3D = get_node_or_null("Camera3D")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#global_position = get_owner().get_node("Party").global_position
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	var movement = Input.get_vector("left", "right", "up", "down")
	
	position = position + Vector3(movement.x, 0.0, movement.y) * 7.5
	cam2d.position += movement * 7.5
	
func _input(event: InputEvent) -> void:
	if event.is_action("zoom_in"):
		cam3d.make_current()
		cam2d.enabled = false
		return
	if event.is_action("zoom_out"):
		cam2d.enabled = true
		cam3d.clear_current()
		return
