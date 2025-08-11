class_name Keypad extends Interactable

var pass_code: String

var attached_door: Door
var is_open := false

var is_operating := false

func interact() -> void:
	if not is_operating and not is_open:
		SignalBus.keypad_operation_started.emit(self)

func set_unlocked(open: bool) -> void:
	is_open = open

	if (open):
		attached_door.is_locked = false


func finish_typing() -> void:
	pass
