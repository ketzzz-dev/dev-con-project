extends Control

@export var sceneName: String

func _ready() -> void:
	$Audio/BGM.play()
	$AudioPanel.visible = false

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_start_pressed() -> void:
	_play_button_sound()
	get_tree().change_scene_to_file("res://scenes/world/levels/" + sceneName + ".tscn")

func _on_settings_pressed() -> void:
	_play_button_sound()
	$VBoxContainer.visible = false
	$AudioPanel.visible = true

func _play_button_sound():
	$Audio/Button.play()

func _on_leave_pressed() -> void:
	_play_button_sound()
	$VBoxContainer.visible = true
	$AudioPanel.visible = false
