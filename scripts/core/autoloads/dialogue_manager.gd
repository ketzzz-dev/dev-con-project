extends Node

var current_graph: DialogueGraph
var current_node: DialogueNode
var current_nodes: Dictionary[StringName, DialogueNode] = {}

var is_active := false
var is_selecting := false

func start_dialogue(graph: DialogueGraph) -> void:
	if is_active: return
	if graph == null or graph.nodes == null or graph.nodes.is_empty(): return
	
	current_nodes.clear()

	for node in graph.nodes:
		if node and node.id != "":
			current_nodes.set(node.id, node)

	if not current_nodes.has("start"):
		return
	
	current_graph = graph
	current_node = current_nodes.get("start")
	is_active = true

	SignalBus.dialogue_started.emit()
	SignalBus.dialogue_node_entered.emit(current_node)

func end_dialogue() -> void:
	if not is_active: return

	if is_selecting:
		is_selecting = false

		SignalBus.dialogue_selection_ended.emit()
	if current_node:
		SignalBus.dialogue_node_exited.emit(current_node)

	await get_tree().physics_frame # To avoid reactivating the dialogue

	is_active = false

	SignalBus.dialogue_ended.emit()

func advance_dialogue() -> void:
	if not is_active or is_selecting: return

	if current_node.connections == null or current_node.connections.is_empty():
		end_dialogue()

		return
	
	if current_node.connections.size() == 1:
		var next_node := current_node.connections[0].next_node

		if not current_nodes.has(next_node):
			end_dialogue()

			return
			
		SignalBus.dialogue_node_exited.emit(current_node)
		
		current_node = current_nodes.get(next_node)

		SignalBus.dialogue_node_entered.emit(current_node)
	else:
		handle_branching(current_node.connections)

func handle_branching(connections: Array[DialogueConnection]) -> void:
	if not is_active or is_selecting: return

	is_selecting = true

	SignalBus.dialogue_selection_started.emit(connections)

func select_branch(id: StringName) -> void:
	if not is_active or not is_selecting: return

	for connection in current_node.connections:
		if connection.id != id: continue
		
		SignalBus.dialogue_selection_made.emit(connection)
		
		if not current_nodes.has(connection.next_node):
			end_dialogue()

			return

		is_selecting = false
		
		SignalBus.dialogue_selection_ended.emit()
		SignalBus.dialogue_node_exited.emit(current_node)
		
		current_node = current_nodes.get(connection.next_node)

		SignalBus.dialogue_node_entered.emit(current_node)
