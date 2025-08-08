extends Control

func _ready() -> void:
	$Audio/BGM.play()

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_start_pressed() -> void:
	_play_button_sound()
	get_tree().change_scene_to_file("res://scenes/test.tscn")


func _on_settings_pressed() -> void:
	_play_button_sound()
	$VBoxContainer.visible = false;

func _play_button_sound():
	$Audio/ButtonSFX.play()
