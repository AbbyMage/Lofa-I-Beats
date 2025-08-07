extends Control

enum GameMode {fnf, circle, bar}
var current_mode: GameMode = GameMode.fnf

@export var current_game: String = "fnf"

@onready var circle_skill_check = $circle
@onready var bar_skill_check = $bar
@onready var fnf_arrow_mode = $Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	switch_to_mode(current_mode)

func switch_to_mode(mode: GameMode) :
	current_mode = mode
	
	circle_skill_check.visible = false
	bar_skill_check.visible = false
	fnf_arrow_mode.visible = false
	
	match mode:
		GameMode.fnf:
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
