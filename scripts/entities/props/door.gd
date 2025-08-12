class_name Door extends Interactable

var new_pos_node: Node
var is_locked: bool
var dialogue_locked: DialogueGraph

@export var door_fade: Control

func interact() -> void:
	if (is_locked):
		DialogueManager.start_dialogue(dialogue_locked)
	else:
		# Fade first
		var tween = create_tween()
		door_fade.visible = true
		door_fade.get_node("fade").position = Vector2(1152.0, 0)
		tween.tween_property(door_fade.get_node("fade"), "position", Vector2(-1152.0, 0), 1)

		await get_tree().create_timer(0.5).timeout
		
		get_tree().current_scene.get_node("Player").position = new_pos_node.global_position

		await tween.finished
		door_fade.visible = false
