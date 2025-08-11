extends Label

const OPTION_POOL_SIZE := 4
const TYPE_AUDIO_POOL_SIZE := 4

const Option: PackedScene = preload("res://scenes/ui/components/option_ui.tscn")

@export var options_container: HBoxContainer
@export var type_timer: Timer
@export var type_audio: AudioStreamPlayer

var option_pool: Array[Button] = []
var type_audio_pool: Array[AudioStreamPlayer] = []

var type_audio_index = 0

func _ready() -> void:
	visible = false
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

	SignalBus.dialogue_started.connect(_on_dialogue_started)
	SignalBus.dialogue_ended.connect(_on_dialogue_ended)
	SignalBus.dialogue_node_entered.connect(_on_node_entered)
	SignalBus.dialogue_selection_started.connect(_on_selection_started)
	SignalBus.dialogue_selection_ended.connect(_on_selection_ended)

	type_timer.timeout.connect(_on_type_timer_timeout)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("ui_select") or event.is_action_pressed("interact"):
		if !type_timer.is_stopped():
			type_timer.stop()

			visible_characters = text.length()

			return
		
		DialogueManager.advance_dialogue()

func _on_dialogue_started():
	visible = true
	options_container.visible = true

func _on_dialogue_ended():
	visible = false
	options_container.visible = false

func _on_node_entered(node: DialogueNode):
	if !type_timer.is_stopped():
		type_timer.stop()

	text = node.content
	visible_characters = 0

	type_timer.start()

func _on_selection_started(connections: Array[DialogueConnection]) -> void:
	for i in connections.size():
		if i >= OPTION_POOL_SIZE: break

		option_pool[i].visible = true
		option_pool[i].text = connections[i].label

		var on_pressed = func(): DialogueManager.select_branch(connections[i].id)

		option_pool[i].pressed.connect(on_pressed, CONNECT_DEFERRED)

func _on_selection_ended() -> void:
	for option in option_pool:
		option.visible = false

		for connection in option.pressed.get_connections():
			option.pressed.disconnect(connection.callable)

func _on_type_timer_timeout() -> void:
	if visible_characters < text.length():
		type_audio_pool[type_audio_index].play()
		
		type_audio_index = (type_audio_index + 1) % TYPE_AUDIO_POOL_SIZE
		visible_characters += 1
	else:
		type_timer.stop()
