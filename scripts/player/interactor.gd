extends Node

@export var interaction_area: Area3D

@onready var player: CharacterBody3D = get_parent()

var nearby_interactables: Dictionary[Node3D, Interactable] = {}

func _ready() -> void:
	interaction_area.body_entered.connect(on_body_entered)
	interaction_area.body_exited.connect(on_body_exited)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		var interactable = get_closest_interactable()
		
		if interactable: interactable.interact()

func on_body_entered(body: Node3D) -> void:
	for node in body.get_children():
		if node is Interactable: nearby_interactables.set(body, node)
		if node is Outline: node.set_active(true)

func on_body_exited(body: Node3D) -> void:
	nearby_interactables.erase(body)
	
	for node in body.get_children():
		if node is Outline: node.set_active(false)

func get_closest_interactable() -> Interactable:
	var closest: Interactable
	var min_distance := INF
	
	for node in nearby_interactables:
		var distance = player.global_position.distance_to(node.global_position)
		
		if distance < min_distance:
			min_distance = distance
			closest = nearby_interactables[node]
	
	return closest
