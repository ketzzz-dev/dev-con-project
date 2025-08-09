extends Control

const OPTION_POOL_SIZE := 4
const TYPE_AUDIO_POOL_SIZE := 4

const Option: PackedScene = preload("res://scenes/option.tscn")

@export var subtitles: Label
@export var options_container: HBoxContainer
@export var type_timer: Timer
@export var type_audio: AudioStreamPlayer

var option_pool: Array[Button] = []
var type_audio_pool: Array[AudioStreamPlayer] = []

var type_audio_index = 0

func _ready() -> void:
	subtitles.visible = false
	options_container.visible = false

	option_pool.resize(OPTION_POOL_SIZE)
	type_audio_pool.resize(TYPE_AUDIO_POOL_SIZE)

	for i in OPTION_POOL_SIZE:
		option_pool[i] = Option.instantiate()

		option_pool[i].visible = false

		options_container.add_child(option_pool[i])
	for i in TYPE_AUDIO_POOL_SIZE:
		type_audio_pool[i] = type_audio.duplicate()

		add_child(type_audio_pool[i])

	DialogueManager.dialogue_started.connect(on_dialogue_started)
	DialogueManager.dialogue_ended.connect(on_dialogue_ended)
	DialogueManager.node_entered.connect(on_node_entered)
	DialogueManager.selection_started.connect(on_selection_started)
	DialogueManager.selection_ended.connect(on_selection_ended)

	type_timer.timeout.connect(on_type_timer_timeout)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("ui_select") or event.is_action_pressed("interact"):
		if !type_timer.is_stopped():
			type_timer.stop()

			subtitles.visible_characters = subtitles.text.length()

			return
		
		DialogueManager.advance_dialogue()

func on_dialogue_started():
	subtitles.visible = true
	options_container.visible = true

func on_dialogue_ended():
	subtitles.visible = false
	options_container.visible = false

func on_node_entered(node: DialogueNode):
	if !type_timer.is_stopped():
		type_timer.stop()

	subtitles.text = node.content
	subtitles.visible_characters = 0

	type_timer.start()

func on_selection_started(connections: Array[DialogueConnection]) -> void:
	for i in connections.size():
		if i >= OPTION_POOL_SIZE: break

		option_pool[i].visible = true
		option_pool[i].text = connections[i].label

		var on_pressed = func(): DialogueManager.select_branch(connections[i].label)

		option_pool[i].pressed.connect(on_pressed, CONNECT_DEFERRED)

func on_selection_ended() -> void:
	for option in option_pool:
		option.visible = false

		for connection in option.pressed.get_connections():
			option.pressed.disconnect(connection.callable)

func on_type_timer_timeout() -> void:
	if subtitles.visible_characters < subtitles.text.length():
		type_audio_pool[type_audio_index].play()
		
		type_audio_index = (type_audio_index + 1) % TYPE_AUDIO_POOL_SIZE
		subtitles.visible_characters += 1
	else:
		type_timer.stop()
