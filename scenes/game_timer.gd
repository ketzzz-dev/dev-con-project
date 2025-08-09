extends Node

@export var sceneName: String

@onready var label = $Label
@onready var timer = $Timer

func _ready() -> void:
	timer.start()
	
func time_left_to_live(): 
	var time_left = timer.time_left
	var minute = floor(time_left / 60)
	var second = int(time_left) % 60
	_check_timer(minute, second)
	return [minute, second]

func _process(delta: float) -> void:
	label.text = "%02d:%02d" % time_left_to_live()
	
func _check_timer(minute: int, second: int) -> void:
	if minute == 0 and second == 0:
		get_tree().change_scene_to_file("res://scenes/%s.tscn" % sceneName)
