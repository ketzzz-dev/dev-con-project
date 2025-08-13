extends Node

signal turn_made(turns_left: int)

var turns_left := 4

func _ready() -> void:
	SignalBus.dialogue_selection_made.connect(_on_selection_made)
	SignalBus.dialogue_node_entered.connect(_on_node_entered)
	
func _on_selection_made(connection: DialogueConnection) -> void:
	match connection.id:
		"passcode_01": turn()
		"nothing_02", "about_place": turn()

func _on_node_entered(node: DialogueNode) -> void:
	if node.id == "the_code":
		turn()
	
func turn() -> void:
	turns_left -= 1
	
	turn_made.emit(turns_left)
	
	if turns_left == 0:
		get_tree().reload_current_scene()
