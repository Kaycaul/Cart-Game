extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var global = get_node("/root/Global")
	var time = global.levelTime
	var mins =floor(time/60)
	var sec = time % 60
	var displayTime = ""
	if(sec < 10):
		displayTime = (str(mins)+ ":" +"0"+ str(sec))
	else:
		displayTime = (str(mins)+ ":" + str(sec))
	
	$Time.text = displayTime
	
	
	var levelScore = time * 100
	$LevelScore.text = str(levelScore)
	
	global.totalScore += levelScore
	$TotalScore.text = str(global.totalScore)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Next_level_pressed():
	var global = get_node("/root/Global")
	global.currentLevel +=1
	var changeScene = ""
	if global.currentLevel == 5: 
		changeScene = 'res://Scenes/DemoEnd.tscn'
	else:
		changeScene = "res://Scenes/Level"+str(global.currentLevel)+ "Intro.tscn"
	
	get_tree().change_scene(changeScene)
	
	pass # Replace with function body.
