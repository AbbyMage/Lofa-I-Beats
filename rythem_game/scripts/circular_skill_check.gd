extends Control


const min_rot: float = deg_to_rad(180)
const max_rot: float = deg_to_rad(-180)
const max_good_offset: float = deg_to_rad(15)
const min_good_offset: float = deg_to_rad(-15)

var pointer_speed: float = deg_to_rad(5)
var clockwise: bool = true
var perfect_width: float = deg_to_rad(8)
var good_width: float = deg_to_rad(22.5)

var good_max_offset: float
var good_min_offset: float
var perfect_max_offset: float
var perfect_min_offset: float

var pointer_rot: float

@onready var circle: Node = get_node("Circle")
@onready var good: Node = get_node("Circle/Good")
@onready var perfect: Node = get_node("Circle/Perfect")
@onready var pointer: Node = get_node("Circle/Pointer")

func _ready() -> void:
	_set_pos()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pointer_rot = wrapf(pointer.rotation, -PI, PI)
	

	if clockwise:
		pointer.rotation += pointer_speed
	else:
		pointer.rotation += -pointer_speed
	
	var perfect_
	if Input.is_action_just_pressed("space"):
		if pointer_rot >= perfect_min_offset and pointer_rot <= perfect_max_offset:
			print("perfect")
		else:
			if pointer_rot >= good_min_offset and pointer_rot <= good_max_offset:
				print("good")
			else:
				print("miss")
		_set_pos()

func _set_pos() -> void:
	perfect.rotation = randf_range(min_rot, max_rot)
	good.rotation = perfect.rotation + randf_range(min_good_offset, max_good_offset)
	
	good_max_offset = good.rotation + good_width
	good_min_offset = good.rotation - good_width
	
	perfect_max_offset = good.rotation + perfect_width
	perfect_min_offset = good.rotation - perfect_width
	
	#print("good max: " + str(good_max_offset))
	#print("good min: " + str(good_min_offset))
	#print("P max: " + str(perfect_max_offset))
	#print("P min: " + str(perfect_min_offset))
	#print("pointer rot: " + str(pointer_rot))
	#print("---------------")
	
	
	
