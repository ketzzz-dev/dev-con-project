class_name Lever extends Interactable


func interact() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/screens/main_menu.tscn")
