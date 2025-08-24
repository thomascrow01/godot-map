extends Node3D

#created: 10.08.2025

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#global_position = get_owner().get_node("Party").global_position
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	var movement = Input.get_vector("left", "right", "up", "down")
	
	position = position + Vector3(movement.x, 0.0, movement.y) * 7.5
