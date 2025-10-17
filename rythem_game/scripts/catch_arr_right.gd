extends Area2D
#code for cahting arrows
var tracked_areas: Array[Area2D] = []

@onready var control: Node = get_node("/root/Control")

func _on_area_entered(area: Area2D) -> void:
	if not tracked_areas.has(area):
		tracked_areas.append(area)

func _on_area_exited(area: Area2D) -> void:
	tracked_areas.erase(area)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_right"):  # right Arrow key
		
		if tracked_areas.is_empty():
			print("Empty!")
		else:
			for area in tracked_areas:
				if is_instance_valid(area):
					area.queue_free()
			tracked_areas.clear()
			control._add_score()
