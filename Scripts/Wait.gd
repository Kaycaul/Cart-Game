extends Timer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func wait(s): 
	print("In wait")
	var timer = Timer.new()
	timer.setwaittime(s)
	timer.setoneshot(true)
	self.add_child(timer)
	timer.start()
	yield(timer, "timeout")
	timer.queue_free()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
