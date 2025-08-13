extends Control

enum GameMode {
	fnf, 
	circle, 
	bar}
	
var current_mode: GameMode = GameMode.fnf

var score = 0
var combo_max = 5

@export var current_game: String = "fnf"

@onready var circle_skill_check = $circle
@onready var bar_skill_check = $bar
@onready var fnf_arrow_mode = $"Arrow spaner"
@onready var up_arrow = $up
@onready var down_arrow = $down
@onready var left_arrow = $left
@onready var right_arrow = $right

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	switch_to_mode(current_mode)


func _add_score() -> void:
	score += 1


func switch_to_mode(mode: GameMode) :
	current_mode = mode
	
	circle_skill_check.visible = false
	bar_skill_check.visible = false
	fnf_arrow_mode.visible = false
	right_arrow.visible = false
	down_arrow.visible = false
	left_arrow.visible = false
	up_arrow.visible = false
	
	match mode:
		GameMode.fnf:
			right_arrow.visible = true
			down_arrow.visible = true
			left_arrow.visible = true
			up_arrow.visible = true
			fnf_arrow_mode.visible = true
		GameMode.circle:
			circle_skill_check.visible = true
		GameMode.bar:
			bar_skill_check.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("1"):
		current_game = "fnf"
		switch_to_mode(GameMode.fnf)
	elif Input.is_action_just_pressed("2"):
		current_game = "circle"
		switch_to_mode(GameMode.circle)
	elif Input.is_action_just_pressed("3"):
		current_game = "bar"
		switch_to_mode(GameMode.bar)
	elif score == combo_max:
		current_game = "bar"
		switch_to_mode(GameMode.bar)
		
