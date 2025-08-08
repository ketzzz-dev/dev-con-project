extends Node

@export var proximity: float

@onready var player: CharacterBody3D = get_parent()

var closest_interactable: Interactable

func _physics_process(_delta: float) -> void:
	closest_interactable = get_closest_interactable()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and closest_interactable:
		closest_interactable.interact()

func get_closest_interactable() -> Interactable:
	var closest: Interactable = null
	var min_distance := proximity

	for node in get_tree().get_nodes_in_group("Interactable"):
		var distance := player.position.distance_to(node.global_position)

		if distance < min_distance:
			min_distance = distance
			closest = node

	return closest
