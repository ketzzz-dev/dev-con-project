extends Control

@export var item_icon: TextureRect
@export var item_text: RichTextLabel

func set_item(item: Item) -> void:
	item_icon.texture = item.item_sprite.texture
	item_text.text = item.item_name
	pass

func clear_item() -> void:
	item_icon.texture = null
	item_text.text = "None"