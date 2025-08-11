extends Interactable

@export var salutations: DialogueGraph
@export var talk: DialogueGraph

var has_asked_passcode := false

func _ready() -> void:
	SignalBus.dialogue_selection_made.connect(_on_selection_made)
	
func _on_selection_made(connection: DialogueConnection) -> void:
	match connection.id:
		"passcode_01": has_asked_passcode = true
	
func interact() -> void:
	if has_asked_passcode:
		DialogueManager.start_dialogue(talk)
	else:
		DialogueManager.start_dialogue(salutations)
