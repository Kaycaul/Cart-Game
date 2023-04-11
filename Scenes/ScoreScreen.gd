extends Control

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
	var onParTime = 0
	match global.currentLevel: 
		1:
			onParTime = 45 
		2:
			onParTime = 75
		3:
			onParTime = 90
		4: 
			onParTime = 60
	var subTotal = 0 

	var diff = onParTime - time

	if (diff < -9): 
		subTotal = -900
	else:
		subTotal = 100 * diff
	
	var levelScore = 1000 + subTotal
	$LevelScore.text = str(levelScore)
	
	global.totalScore += levelScore
	$TotalScore.text = str(global.totalScore)
	
	#update coin count
	$CanvasLayer/CoinHUD/CoinLabel.text = "$%.2f" % (global.totalNickels * 0.05)

func _on_Next_level_pressed():
	var global = get_node("/root/Global")
	global.currentLevel +=1
	print(global.currentLevel) #for testing
	var changeScene = ""
	if global.currentLevel == 6: 
		changeScene = 'res://Scenes/DemoEnd.tscn'
	#elif global.currentLevel == 5:
		#if enough coins, go to good ending
		#if global.totalNickels >= 80:
		#	changeScene = 'res://Scenes/EndGood.tscn'
		#if not enough coins, go to bad ending
		#else:
		#	changeScene = 'res://Scenes/EndBad.tscn'
	else:
		changeScene = "res://Scenes/Level"+str(global.currentLevel)+ "Intro.tscn"
	global.levelTime = 0
	
	get_tree().change_scene(changeScene)
	
	pass # Replace with function body.
