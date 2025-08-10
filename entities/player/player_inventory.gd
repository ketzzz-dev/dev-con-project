extends Node

var held_item: Item

func set_item(item: Item) -> void:
	held_item = item
	
	EventBus.inventory_item_set.emit(held_item)

func clear_item() -> void:
	held_item = null
	
	EventBus.inventory_item_cleared.emit()
