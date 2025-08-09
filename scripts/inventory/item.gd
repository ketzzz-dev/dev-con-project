class_name Item extends Interactable

enum ItemType {
	PlaceholderSuzuka
}

@export var item_type: ItemType
@export var item_name: String
@export var item_sprite: Sprite3D

# When it works, it works its bad but man
func interact() -> void:
	print("I got %s!" % item_name)
	get_tree().current_scene.get_node("%Player").get_node("%Inventory").set_item(self)
	
	get_parent().queue_free()
