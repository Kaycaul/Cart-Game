extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

#change scene when Area2D at end of track is entered by player
func _on_BeginningOfLevel3Area2D_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	#remove obstacles from past scenes before spawning new ones in
	for child in get_node("/root").get_children():
		if child.get_class() == "Area2D" or child.get_class() == "RigidBody2D":
			child.position = child.position + Vector2(10000,0)
	
	if(str(area).split(":")[0].rstrip("0123456789@").lstrip("@") == "PlayerObject"):
		get_tree().change_scene("res://Scenes/Level3End.tscn")
