extends Area2D

var fall_velocity: float = 0.0
var is_paused: bool = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("2"):
		visible = false 
		is_paused = true
		is_paused = !is_paused
	elif  Input.is_action_just_pressed("3"):
		visible = false
		is_paused = true
	elif  Input.is_action_just_pressed("1"):
		visible = true
		is_paused = false
		
	if Input.is_action_just_pressed("p"):  # Space bar pause
		is_paused = !is_paused

	if is_paused:
		return  


	fall_velocity += 35 * delta


	position.y += fall_velocity * delta

	
	
	
