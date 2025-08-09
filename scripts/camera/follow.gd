extends Camera3D

@export var target: Node3D
@export var offset: Vector3

func _process(_delta: float) -> void:
	position = target.global_position + offset
	
	look_at(target.global_position, Vector3.UP)
