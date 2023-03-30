extends Label

var time = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var Transform2d = get_viewport().get_canvas_transform()
	get_viewport().set_canvas_transform(Transform2d)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	time +=1 

	var mins =floor(time/60)
	var sec = time % 60
	var displayTime = ""
	if(sec < 10):
		displayTime = (str(mins)+ ":" +"0"+ str(sec))
	else:
		displayTime = (str(mins)+ ":" + str(sec))
	
	text = displayTime
	print(text)
