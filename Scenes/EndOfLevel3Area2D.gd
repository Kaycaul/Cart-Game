extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#change scene when Area2D at end of track is entered by player
func _on_EndOfLevel3Area2D_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if(str(area).split(":")[0].rstrip("0123456789@").lstrip("@") == "PlayerObject"):
		get_tree().change_scene("res://Scenes/Level4Intro.tscn")
