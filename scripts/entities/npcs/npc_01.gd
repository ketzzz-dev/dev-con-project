extends Interactable

@export var ask_passcode: DialogueGraph
@export var talk_to_him: DialogueGraph
@export var tell_passcode: DialogueGraph

var has_asked_passcode := false
var has_talked := false

func _ready() -> void:
	SignalBus.dialogue_selection_made.connect(_on_selection_made)

func _on_selection_made(connection: DialogueConnection) -> void:
	match connection.id:
		"passcode_01": has_asked_passcode = true
		"nothing_02", "about_place": has_talked = true
		
func interact() -> void:
	if has_asked_passcode:
		if has_talked:
			DialogueManager.start_dialogue(tell_passcode)
		else:
			DialogueManager.start_dialogue(talk_to_him)
	else:
		DialogueManager.start_dialogue(ask_passcode)
