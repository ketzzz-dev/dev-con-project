extends TextureRect

@export var turns: Array[Texture2D]

func _ready() -> void:
	texture = turns[turns.size() - 1]
	
	LoopManager.turn_made.connect(_on_turn_made)
	
func _on_turn_made(turns_left: float) -> void:
	texture = turns[turns_left - 1]
