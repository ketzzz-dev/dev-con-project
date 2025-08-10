extends Node

@export var interaction_area: Area3D

@onready var player: CharacterBody3D = get_parent()

var nearby_interactables: Dictionary[Node3D, Interactable] = {}

func _ready() -> void:
	interaction_area.body_entered.connect(_on_node_entered)
	interaction_area.area_entered.connect(_on_node_entered)
	interaction_area.body_exited.connect(_on_node_exited)
	interaction_area.area_exited.connect(_on_node_exited)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		var interactable = get_closest_interactable()
		
		if interactable: interactable.interact()

func _on_node_entered(node: Node3D) -> void:
	for child in node.get_children():
		if child is Interactable:
			nearby_interactables.set(node, child)
		if child is Outline:
			child.set_active(true)

func _on_node_exited(node: Node3D) -> void:
	if nearby_interactables.has(node):
		nearby_interactables.erase(node)
	
	for child in node.get_children():
		if child is Outline:
			child.set_active(false)

func get_closest_interactable() -> Interactable:
	var closest: Interactable = null
	var min_distance := INF
	
	for node in nearby_interactables.keys():
		var distance = player.global_position.distance_to(node.global_position)
		
		if distance < min_distance:
			min_distance = distance
			closest = nearby_interactables[node]
	
	return closest
