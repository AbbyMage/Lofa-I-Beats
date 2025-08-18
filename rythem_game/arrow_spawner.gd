extends Node2D

@export var left_arrow_scene: PackedScene
@export var right_arrow_scene: PackedScene
@export var up_arrow_scene: PackedScene
@export var down_arrow_scene: PackedScene



@export var spawn_list: Array[String] = [
	"left", "blank", "up", "down", "blank", "right", 
	"left", "up", "blank", "blank", "down", "right",
	"left", "up", "down", "right", "blank", "left",
	"up", "blank", "right", "down", "blank", "left",
	"left", "up", "down", "blank", "right", "blank",
	"up", "down", "right", "left", "blank", "blank",
	"right", "down", "up", "left", "blank", "down",
	"right", "up", "blank", "left", "down", "up",
	"left", "blank", "up", "down", "blank", "right", 
	"left", "up", "blank", "blank", "down", "right",
	"left", "up", "down", "right", "blank", "left",
	"up", "blank", "right", "down", "blank", "left",
	"left", "up", "down", "blank", "right", "blank",
	"up", "down", "right", "left", "blank", "blank",
	"right", "down", "up", "left", "blank", "down",
	"right", "up", "blank", "left", "down", "up"

]

@export var spawn_interval = 0.5
@export var start_y = 0.0

@export var left_lane_x = 200.0
@export var up_lane_x = 500.0
@export var down_lane_x = 350.0
@export var right_lane_x = 650.0

var base_fall_velocity = 450.0
var acceleration = 175.0

var current_index = 0
var timer = 0.0
var is_paused = false


var acceleration_enabled = false

var active_arrows = []

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("p"):
		is_paused = !is_paused

	if is_paused:
		return

	if Input.is_action_just_pressed("j"):
		acceleration_enabled = true  

	# spawn arrows
	timer += delta
	if timer >= spawn_interval and current_index < spawn_list.size():
		timer = 0.0
		var action = spawn_list[current_index]
		if action != "blank":
			var arrow = spawn_arrow(action)
			if arrow:
				active_arrows.append({"node": arrow, "velocity": base_fall_velocity})
		current_index += 1

	
	for i in range(active_arrows.size() - 1, -1, -1): # i got help from andrew understand how to set up my for loop but i understand how it works and thats its telling all active arrows to check how they are falling 
		var arrow_dict = active_arrows[i]
		var arrow_node = arrow_dict["node"]

	
		if not is_instance_valid(arrow_node):
			active_arrows.remove_at(i)
			continue

		#acceleration
		if acceleration_enabled:
			arrow_dict["velocity"] += acceleration * delta

		# move arrow
		arrow_node.position.y += arrow_dict["velocity"] * delta

		# so thery dont exist in a sean forever after they travle a cetian distance they will dispawn 
		if arrow_node.position.y > 1800:
			arrow_node.queue_free()
			active_arrows.remove_at(i)

func spawn_arrow(direction: String) -> Node2D:
	var scene: PackedScene
	var x_pos := 0.0

	match direction:
		"left":
			scene = left_arrow_scene
			x_pos = left_lane_x
		"up":
			scene = up_arrow_scene
			x_pos = up_lane_x
		"down":
			scene = down_arrow_scene
			x_pos = down_lane_x
		"right":
			scene = right_arrow_scene
			x_pos = right_lane_x
		_: 
			return null

	if scene:
		var arrow = scene.instantiate()
		arrow.position = Vector2(x_pos, start_y)
		add_child(arrow)
		return arrow

	return null
