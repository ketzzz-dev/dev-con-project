extends Node

@export var animation_tree: AnimationTree

@onready var player: CharacterBody3D = get_parent()

var last_direction = Vector2.UP

func _physics_process(_delta: float) -> void:
	var is_moving = player.velocity.length_squared() > 0.25
	
	if is_moving:
		last_direction = Vector2(player.velocity.x, player.velocity.z).normalized()
	
	animation_tree.set("parameters/conditions/is_idling", !is_moving)
	animation_tree.set("parameters/conditions/is_moving", is_moving)

	animation_tree.set("parameters/Idle/blend_position", last_direction)
	animation_tree.set("parameters/Move/blend_position", last_direction)
