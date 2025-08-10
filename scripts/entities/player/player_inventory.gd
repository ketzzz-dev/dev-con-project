extends Node

var held_item: Item

func set_item(item: Item) -> void:
	held_item = item
	
	SignalBus.inventory_item_set.emit(held_item)

func clear_item() -> void:
	held_item = null
	
	SignalBus.inventory_item_cleared.emit()
