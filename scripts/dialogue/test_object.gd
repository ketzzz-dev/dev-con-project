extends Interactable

@export var graph: DialogueGraph

func interact() -> void:
	DialogueManager.start_dialogue(graph)
