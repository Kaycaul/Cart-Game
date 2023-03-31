extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_EndOfLevel4Area2D_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if(str(area).split(":")[0].rstrip("0123456789@").lstrip("@") == "PlayerObject"):
		get_tree().change_scene("res://Scenes/DemoEnd.tscn")
