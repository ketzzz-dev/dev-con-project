extends Control

@export var item_icon: TextureRect
@export var item_text: RichTextLabel

func _ready() -> void:
	EventBus.inventory_item_set.connect(_on_item_set)
	EventBus.inventory_item_cleared.connect(_on_item_cleared)

func _on_item_set(item: Item) -> void:
	item_icon.texture = item.item_sprite.texture
	item_text.text = item.item_name

func _on_item_cleared() -> void:
	item_icon.texture = null
	item_text.text = "None"
