extends Control
const POINTS_TO_WIN = 30
var score = 0
#spin 
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

@onready var score_label = $ScoreLabel

func _ready() -> void:
	update_score_lable()
	_set_pos()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pointer_rot = wrapf(pointer.rotation, -PI, PI)
	

	if clockwise:
		pointer.rotation += pointer_speed
	else:
		pointer.rotation += -pointer_speed
	
	var perfect_
	
	if Input.is_action_just_pressed("space") and get_parent().current_game == self.name:
		if pointer_rot >= perfect_min_offset and pointer_rot <= perfect_max_offset:
			print("perfect")
			score += 2 
			update_score_lable()
		else:
			if pointer_rot >= good_min_offset and pointer_rot <= good_max_offset:
				print("good")
				score += 1  
				update_score_lable()
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
	
func update_score_lable():
	score_label.text = "Score: " + str(score) + " / " + str(POINTS_TO_WIN)
