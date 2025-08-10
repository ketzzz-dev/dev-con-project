extends Node

signal dialogue_started
signal dialogue_ended

signal node_entered(node: DialogueNode)
signal node_exited(node: DialogueNode)

signal selection_started(connections: Array[DialogueConnection])
signal selection_ended

var current_graph: DialogueGraph
var current_node: DialogueNode
var current_nodes: Dictionary[StringName, DialogueNode] = {}

var is_active := false
var is_selecting := false

func start_dialogue(graph: DialogueGraph) -> void:
	if is_active: return
	if graph.nodes == null or graph.nodes.size() == 0: return
	
	current_nodes.clear()

	for node in graph.nodes:
		current_nodes.set(node.id, node)

	if not current_nodes.has("start"):
		return
	
	current_graph = graph
	current_node = current_nodes.get("start")
	is_active = true

	dialogue_started.emit()
	node_entered.emit(current_node)

func end_dialogue() -> void:
	if not is_active: return

	if is_selecting:
		is_selecting = false

		selection_ended.emit()

	await get_tree().physics_frame # To avoid reactivating the dialogue

	is_active = false

	dialogue_ended.emit()

func advance_dialogue() -> void:
	if not is_active or is_selecting: return

	if current_node.connections == null or current_node.connections.size() == 0:
		end_dialogue()
	elif current_node.connections.size() == 1:
		var next_node := current_node.connections[0].next_node

		if not current_nodes.has(next_node):
			end_dialogue()

			return
		
		node_exited.emit(current_node)
		
		current_node = current_nodes.get(next_node)

		node_entered.emit(current_node)
	else:
		handle_branching(current_node.connections)

func handle_branching(connections: Array[DialogueConnection]) -> void:
	if not is_active or is_selecting: return

	is_selecting = true

	selection_started.emit(connections)

func select_branch(label: StringName) -> void:
	if not is_active or not is_selecting: return

	for connection in current_node.connections:
		if connection.label != label: continue

		if not current_nodes.has(connection.next_node):
			end_dialogue()

			return

		is_selecting = false

		selection_ended.emit()
		node_exited.emit(current_node)
		
		current_node = current_nodes.get(connection.next_node)

		node_entered.emit(current_node)
