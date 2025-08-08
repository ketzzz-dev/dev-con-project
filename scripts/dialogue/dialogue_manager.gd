extends Node

signal dialogue_started
signal dialogue_enter
signal dialogue_exit
signal dialogue_ended

signal selection_started
signal selection_ended

var is_active := false
var is_selecting := false

func start_dialogue(graph) -> void:
	if is_active: return
	
