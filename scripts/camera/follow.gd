extends Node3D

@export var target: Node3D
@export var offset: Vector3

@onready var camera: Camera3D = get_parent()

func _process(_delta: float) -> void:
	camera.position = target.global_position + offset
	camera.look_at(target.global_position, Vector3.UP)
