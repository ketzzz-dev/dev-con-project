extends Area3D
class_name Item

enum ItemType {
	PlaceholderSuzuka
}

@export var item_type: ItemType
@export var item_name: String
@onready var item_sprite: Sprite3D = $Sprite3D

func _on_item_entered(body: Node3D) -> void:
	if body.get_groups()[0] == "player":
		print("I have gotten %s" % [item_name])
