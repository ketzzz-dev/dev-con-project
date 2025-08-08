extends HSlider

@export var bus_name: String
var bus_index: int

func _ready() -> void:
	bus_index = AudioServer.get_bus_index(bus_name)

	# Get current dB and convert to linear for slider
	var db = AudioServer.get_bus_volume_db(bus_index)
	value = db_to_linear(db)

	value_changed.connect(_on_value_changed)

func _on_value_changed(value: float) -> void:
	# Clamp to avoid -inf from 0.0
	var safe_value = clamp(value, 0.0001, 5)
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(safe_value))
