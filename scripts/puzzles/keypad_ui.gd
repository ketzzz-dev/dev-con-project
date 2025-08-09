extends Control

var buttons: Array[Button]
var current_keypad: Keypad

func _ready():
	for node in get_children():
		if node is Button:
			buttons.push_back(node)

	for button in buttons:
		button.pressed.connect(button_pressed)

func button_pressed():
	print("pRESED")
	pass
