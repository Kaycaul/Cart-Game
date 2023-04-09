extends Button

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Level5Button_pressed():
	#if enough coins, go to good ending
	if get_node("/root/Global").totalNickels >= 80:
		get_tree().change_scene("res://Scenes/EndGood.tscn")
	#if not enough coins, go to bad ending
	else:
		get_tree().change_scene("res://Scenes/EndBad.tscn")
