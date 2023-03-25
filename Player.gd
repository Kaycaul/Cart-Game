extends Area2D

onready var path_follow = get_parent() # gets the parent (which should be a path follower) to move the player

export var accel = 0.5
export var MAX_SPEED = 601
export var DEFAULT_SPEED = 100

var move_speed = DEFAULT_SPEED
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
	print(move_speed)
	if move_speed < MAX_SPEED:
		move_speed += accel
	
	# move side/side on the path (up and down on the path)
	position.y = side_movement


func collideWithObstacle():
	$CollisionEffect.play()
	print ("in here 2")
	print(path_follow.get_offset())
	position.x = position.x - 50
	if((floor(move_speed / 100)) - 2 > 0):
		$RemoteCartCamera.position.x -= 2.5 * ((floor(move_speed / 100)) - 2)
	print("entering wait")
	
	#play skid animation
	$AnimationPlayer.play("skid")
	
	position.x = position.x + 50
	accel = 0.5
	move_speed = DEFAULT_SPEED	
	print("exited wait")


func _on_PlayerObject_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	if(str(area).split(":")[0].rstrip("0123456789@").lstrip("@") == "Obstacle"):
		collideWithObstacle()