class_name Keypad extends Interactable

@export var pass_code: String

var is_operating := false
var is_open := false

func interact() -> void:
	if not is_operating and not is_open:
		SignalBus.keypad_operation_started.emit(self)

func finish_typing() -> void:
	pass
