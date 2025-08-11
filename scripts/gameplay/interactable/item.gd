class_name Item extends Interactable

enum ItemType {
	PlaceholderSuzuka,
	Axe
}

@export var item_type: ItemType
@export var item_name: String
@export var item_sprite: Sprite3D

# When it works, it works its bad but man
func interact() -> void:
	SignalBus.inventory_item_set.emit(self)
	
	get_parent().queue_free()
