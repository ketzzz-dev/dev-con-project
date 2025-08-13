class_name Crate extends Interactable

@export var no_axe: DialogueGraph
var uiTextNode: Control


func interact() -> void:
	var GameUI = get_tree().root.find_child("UI", true, false)
	var uiText = GameUI.find_child("RichTextLabel", true, false)
	if uiText and uiText.text == "Axe":
		LoopManager.turn()
		get_parent().queue_free()
	else:
		print("Hello")
		DialogueManager.start_dialogue(no_axe)
