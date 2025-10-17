
# just ignor this did not end up using it but i thouhgot it was cool







extends CharacterBody2D

@export var follow_strength = 400.0      # acceleration toward mouse
@export var max_speed = 1000.0           # speed cap
@export var friction = 100.0             # friction
@export var min_spin_speed = 1        # min radians per second spin
@export var max_spin_speed = 1         # max radians per second spin
@export var spin_change_interval := 360   # seconds between spin speed changes
@export var wall_bounciness = 1.0        # 1.0 = perfect bounce, 0.5 = soft bounce, etc.

var current_spin_speed = 0.0
var spin_timer = 0.0
var screen_size = Vector2.ZERO

func _ready() -> void:
	_set_new_spin_speed()

func _physics_process(delta: float) -> void:
	# Always update screen size (for fullscreen / resize support)
	screen_size = get_viewport_rect().size

	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - global_position).normalized()

	# Accelerate toward mouse
	velocity += direction * follow_strength * delta

	# Clamp speed
	if velocity.length() > max_speed:
		velocity = velocity.normalized() * max_speed

	# Apply friction
	var drag = velocity.normalized() * friction * delta
	if drag.length() > velocity.length():
		velocity = Vector2.ZERO
	else:
		velocity -= drag

	# Move the player
	move_and_slide()

	# Bounce off left and right edges
	if global_position.x < 0:
		global_position.x = 0
		velocity.x = -velocity.x * wall_bounciness
	elif global_position.x > screen_size.x:
		global_position.x = screen_size.x
		velocity.x = -velocity.x * wall_bounciness

	# Bounce off top and bottom edges
	if global_position.y < 0:
		global_position.y = 0
		velocity.y = -velocity.y * wall_bounciness
	elif global_position.y > screen_size.y:
		global_position.y = screen_size.y
		velocity.y = -velocity.y * wall_bounciness

	# Random slow spin
	spin_timer -= delta
	if spin_timer <= 0:
		_set_new_spin_speed()

	rotation += current_spin_speed * delta

func _set_new_spin_speed() -> void:
	current_spin_speed = randf_range(min_spin_speed, max_spin_speed)
	spin_timer = spin_change_interval
