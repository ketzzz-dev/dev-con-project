extends Node

signal inventory_item_set(item: Item)
signal inventory_item_cleared

signal keypad_operation_started(keypad: Keypad)

signal dialogue_started
signal dialogue_ended

signal dialogue_node_entered(node: DialogueNode)
signal dialogue_node_exited(node: DialogueNode)

signal dialogue_selection_started(connections: Array[DialogueConnection])
signal dialogue_selection_made(connection: DialogueConnection)
signal dialogue_selection_ended
