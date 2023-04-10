extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_start_button_pressed():
	get_tree().change_scene("res://Scenes/Level1Intro.tscn")

func _on_how_to_play_pressed():
	get_tree().change_scene("res://Scenes/helpScreen.tscn")	

func _on_map_button_pressed():
	get_tree().change_scene("res://Scenes/mapScreen.tscn")
