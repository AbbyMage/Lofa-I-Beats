extends Area2D

var fall_velocity: float = 0.0
var is_paused: bool = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):  # Space bar pause
		is_paused = !is_paused

	if is_paused:
		return  

	# keep velocity 
	fall_velocity += 35 * delta

	# Move downward
	position.y += fall_velocity * delta
