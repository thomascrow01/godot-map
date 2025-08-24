class_name Character extends CharacterBody3D

# file created: 10-07-2025
# last edited: 10-07-2025

var display_name: String

var icon: Texture2D
var model: Node3D

func _init(data: CharacterData) -> void:
	
	display_name = data.display_name
	
	if !data.icon_link:
		icon = load("res://icon.svg")
	if !data.model_link:
		model = MeshInstance3D.new()
		model.mesh = BoxMesh.new()
		model.mesh.material.albedo_texture = icon
