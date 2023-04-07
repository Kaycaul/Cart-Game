extends Button

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_DemoEndButton_pressed():
	get_node("/root/Global").totalScore = 0
	get_node("/root/Global").currentLevel = 1
	get_node("/root/Global").totalNickels = 0
	get_tree().change_scene("res://Scenes/startScreen.tscn")
