extends Button

var original_scale := Vector2.ONE
var hover_scale := Vector2(1.1, 1.1)
var hover_color := Color(1, 0.5, 0.5)  
var normal_color := Color(1, 1, 1)    

# Change this to the path of your target scene
const TARGET_SCENE_PATH := "res://scenae/tutorial.tscn"

func _ready():
	original_scale = scale
	add_theme_color_override("font_color", normal_color)

func _on_mouse_entered():
	scale = hover_scale
	add_theme_color_override("font_color", hover_color)

func _on_mouse_exited():
	scale = original_scale
	add_theme_color_override("font_color", normal_color)

func _on_pressed():
	print("pressed")
	get_tree().change_scene_to_file("res://scenae/tutorial.tscn")
