extends DirectionalLight3D

# file created: 16-06-2025
# last edited: 17-07-2025

## script to rotate DirectionalLight3D as if it's a day cycle

# use animation player instead later https://www.youtube.com/watch?v=ZEenlZLltOE

@export var real_time: bool = true

func _ready() -> void:
	#get_node("../DayCycle").play("day_night_cycle")
	pass

#func _process(delta: float) -> void:
	#rotate_z(delta)
	##print(rotation.angle_to(Vector3.UP))
	#if rotation.angle_to(Vector3.UP):
		#pass
