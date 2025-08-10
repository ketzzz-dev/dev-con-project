class_name Outline extends MeshInstance3D

func _ready() -> void:
	if material_overlay is ShaderMaterial:
		material_overlay.set_shader_parameter("is_active", false)

func set_active(active: bool) -> void:
	if material_overlay is ShaderMaterial:
		material_overlay.set_shader_parameter("is_active", active)
