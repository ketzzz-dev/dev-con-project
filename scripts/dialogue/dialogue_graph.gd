class_name DialogueGraph extends Resource

class DialogueNode extends Resource:
	@export var id: StringName
	@export var content: String
	
	@export var connections: Array[DialogueConnection]

class DialogueConnection extends Resource:
	@export var label: String
	@export var next_node: StringName

@export var nodes: Array[DialogueNode]
