class_name Crate extends Interactable

var uiTextNode: Control

func interact() -> void:
	print("Hello")
	var GameUI = get_node("/root/Test/UI")
	var uiText = GameUI.find_child("RichTextLabel", true, false)
	if uiText and uiText.text == "Axe":
		get_parent().queue_free()
