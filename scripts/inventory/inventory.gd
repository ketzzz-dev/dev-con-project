class_name Inventory extends Node

@onready var game_ui: Control = get_tree().current_scene.get_node("GameUI")

var held_item

func set_item(item: Item) -> void:
	held_item = item
	game_ui.get_node("Item").set_item(item)

func clear_item() -> void:
	held_item = null
	game_ui.get_node("Item").clear_item()
