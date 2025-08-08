extends CharacterBody3D

@export var speed: float
@export var acceleration: float
@export var deceleration: float

var input_direction := Vector2.ZERO

func _process(_delta: float) -> void:
	if DialogueManager.is_active:
		input_direction = Vector2.ZERO
	else:
		input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var move_direction := Vector3(input_direction.x, 0, input_direction.y)
	var is_moving := move_direction.length_squared() > 0.25
	
	if is_moving:
		move_direction = move_direction.normalized()
	
	var target_velocity = move_direction * speed
	var delta_velocity = target_velocity - velocity
	var acceleration_rate = acceleration if is_moving else deceleration
	
	velocity.x += delta_velocity.x * acceleration_rate * delta
	velocity.z += delta_velocity.z * acceleration_rate * delta

	move_and_slide()
