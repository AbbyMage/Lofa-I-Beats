extends Control

# variable i might change
@export var base_speed = 300.0
@export var max_speed = 600.0
@export var slow_speed = 50.0
@export var speed_increase = 40.0
@export var speed_recovery = 100.0

@export var min_good_width = 60.0
@export var max_good_width = 100.0
@export var perfect_zone_width = 30.0

const DECAY_DELAY = 1.8  # time before speedo decay

var pointer_speed = 0.0
var going_right = true
var time_since_perfect = 0.0

@onready var bar = $Bar
@onready var pointer = $pointer
@onready var good_zone = $Goodzone
@onready var perfect_zone = $perfect

func _ready():
	randomize()
	pointer_speed = base_speed
	setup_zones()

# sets up the good and perfect zones in random places inside the bar
func setup_zones():
	var bar_start = bar.position.x
	var bar_width = bar.size.x

	var good_width = randf_range(min_good_width, max_good_width)
	var max_good_start = bar_start + bar_width - good_width
	var good_start = randf_range(bar_start + 10, max_good_start - 10)

	good_zone.position.x = good_start
	good_zone.size.x = good_width

	var max_perfect_start = good_start + good_width - perfect_zone_width
	var perfect_start = randf_range(good_start, max_perfect_start)

	perfect_zone.position.x = perfect_start
	perfect_zone.size.x = perfect_zone_width

func _process(delta):
	# keep track of time since last perfect hit
	time_since_perfect += delta

	# recover from skill issue and missing
	if pointer_speed < base_speed:
		pointer_speed = min(pointer_speed + speed_recovery * delta, base_speed)
	elif pointer_speed > base_speed and time_since_perfect > DECAY_DELAY:
		pointer_speed = max(pointer_speed - speed_recovery * delta, base_speed)

	# I like to move it move it
	var bar_left = bar.position.x
	var bar_right = bar.position.x + bar.size.x

	if going_right:
		pointer.position.x += pointer_speed * delta
		if pointer.position.x >= bar_right:
			pointer.position.x = bar_right
			going_right = false
	else:
		pointer.position.x -= pointer_speed * delta
		if pointer.position.x <= bar_left:
			pointer.position.x = bar_left
			going_right = true

# input (space bar goes brrr)
func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		if is_in_zone(perfect_zone):
			print("PERFECT!")
			pointer_speed = min(pointer_speed + speed_increase, max_speed)
			time_since_perfect = 0.0
		elif is_in_zone(good_zone):
			print("Meh could be better!")
		else:
			print("Dissapoingting!")
			pointer_speed = slow_speed
			time_since_perfect = 0.0

		setup_zones()

# checks if pointer is inside the target zone
func is_in_zone(zone: ColorRect) -> bool:
	var pointer_x = pointer.position.x
	var zone_left = zone.position.x
	var zone_right = zone.position.x + zone.size.x
	return pointer_x >= zone_left and pointer_x <= zone_right
