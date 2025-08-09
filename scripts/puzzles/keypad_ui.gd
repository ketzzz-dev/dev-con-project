extends Control

@export var code_text: RichTextLabel

var buttons: Array[Button]
var current_keypad: Keypad
var current_code: String
var correct: bool = false

func _ready():
	for node in get_children():
		if node is Button:
			buttons.push_back(node)

	for button in buttons:
		button.pressed.connect(button_pressed.bind(button))

func start_keypad_ui(keypad: Keypad) -> void:
	current_keypad = keypad
	get_parent().visible = true

	pass

func finish_keypad_ui() -> void:
	if (correct):
		current_keypad.opened = true

	current_code = ""
	code_text.text = ""

	current_keypad = null
	get_parent().visible = false

	pass

func validate_code() -> void:
	print("validating code")
	if (current_code == current_keypad.pass_code):
		code_text.text = "Correct!"
		correct = true
		print("passs correct!")
	else:
		code_text.text = "Wrong Code"
		print("WRONGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG")
	
	await get_tree().create_timer(1.0).timeout

	finish_keypad_ui()

	pass

func button_pressed(button: Button):
	print(button.text)
	current_code += button.text

	code_text.text = current_code

	if (current_keypad.pass_len <= current_code.length()):
		validate_code()

	pass
