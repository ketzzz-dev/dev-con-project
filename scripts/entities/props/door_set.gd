# I am extremely sorry, bandaid solution #1: have a main script for the top level node so that the interactable will have its values set there.
extends StaticBody3D

@export var is_locked: bool = false
@export var new_pos_node: Node
@export var dialogue_locked: DialogueGraph

@onready var interactable: Door = $Interactable

func _ready() -> void:
	interactable.new_pos_node = new_pos_node
	interactable.is_locked = is_locked
	interactable.dialogue_locked = dialogue_locked