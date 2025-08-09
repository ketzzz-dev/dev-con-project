class_name Keypad extends Interactable

@export var pass_code: String
@onready var pass_len: int = pass_code.length()

var is_operating: bool = false

var opened: bool

func interact() -> void:
	if (!is_operating && !opened):
		print("starting ui")
		get_node("../%KeypadUI").get_node("Panel").start_keypad_ui(self)

func finish_typing() -> void:
	pass
