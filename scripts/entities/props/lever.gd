class_name Lever extends Interactable

@export var delayTime: float

func interact() -> void:
	$"../Sprite3D".texture = load("res://assets/Puzzle Sprites/Lever_active.png")
	await get_tree().create_timer(delayTime).timeout
	get_tree().change_scene_to_file("res://scenes/ui/screens/main_menu.tscn")
