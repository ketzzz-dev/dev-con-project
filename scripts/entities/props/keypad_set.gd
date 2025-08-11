# I am extremely sorry, bandaid solution #1: have a main script for the top level node so that the interactable will have its values set there.
extends StaticBody3D

@export var pass_code: String

@export var attached_door: Node3D
@export var is_open := false

@onready var interactable: Keypad = $Interactable

func _ready() -> void:
	interactable.pass_code = pass_code
	interactable.attached_door = attached_door.get_node("Interactable")
	interactable.is_open = is_open 
