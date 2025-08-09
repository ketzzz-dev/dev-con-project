extends Node3D

@export var items = []
var held_item

func add_item(item: Area3D) -> void:
	items.push_back(item)
	pass

func remove_item() -> void:
	pass