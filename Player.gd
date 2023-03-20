extends Area2D

onready var path_follow = get_parent() # gets the parent (which should be a path follower) to move the player

export var move_speed = 1
export var accel = 0.5

var side_movement = 0

func _process(_delta):
	# get player input and change their side_movement
	if Input.is_action_just_pressed("move_left") and side_movement > -30:
		side_movement -= 15
	
	if Input.is_action_just_pressed("move_right") and side_movement < 30:
		side_movement += 15


func _physics_process(delta):
	# moves along the path by a certain speed
	path_follow.set_offset(path_follow.get_offset() + move_speed * delta) 
	move_speed += accel
	
	# move side/side on the path (up and down on the path)
	position.y = side_movement


func collideWithObstacle():
	$CollisionEffect.play()
	print ("in here 2")
	var currentOff = path_follow.get_offset()
	print(path_follow.get_offset())
	position.x = position.x - 50
	print("entering wait")

	move_speed = 0
	accel = 0
	yield(get_tree().create_timer(2.0),"timeout")
	
	
	position.x = position.x + 50
	accel = 0.5
	move_speed = 322	
	print("exited wait")


func _on_PlayerObject_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if(str(area).split(":")[0].rstrip("0123456789") == "Obstacle"):
		collideWithObstacle()
	pass # Replace with function body.
