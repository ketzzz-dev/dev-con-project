extends Control

@export var code_text: RichTextLabel

var buttons: Array[Button]
var current_keypad: Keypad
var current_code: String
var correct: bool = false

func _ready():
	for node in get_children():
		if node is Button:
			buttons.append(node)

	for button in buttons:
		button.pressed.connect(button_pressed.bind(button))
		
	SignalBus.keypad_operation_started.connect(start_keypad_ui)
	
	get_parent().visible = false

func start_keypad_ui(keypad: Keypad) -> void:
	current_keypad = keypad
	get_parent().visible = true
	GameState.freeze_player = true

	pass

func finish_keypad_ui() -> void:
	if (correct):
		current_keypad.set_unlocked(true)

	current_code = ""
	code_text.text = ""

	current_keypad = null
	get_parent().visible = false
	
	GameState.freeze_player = false
	LoopManager.turn()

	pass

func validate_code() -> void:
	print("validating code")
	if (current_code == current_keypad.pass_code):
		code_text.text = "Correct!"
		correct = true
		print("pass correct!")
	else:
		code_text.text = "Incorrect!"
		print("wrong code")
	
	await get_tree().create_timer(1.5).timeout

	finish_keypad_ui()

	pass

func button_pressed(button: Button):
	if (button.text == "<---" && !current_code.is_empty()):
		current_code = current_code.left(-1)
	elif(button.text != "<---"):
		current_code += button.text

	code_text.text = current_code

	if (!current_keypad.pass_code.is_empty()):
		if (current_code.length() >= current_keypad.pass_code.length()):
			validate_code()
