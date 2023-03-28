extends Area2D

onready var path_follow = get_parent() # gets the parent (which should be a path follower) to move the player

export var accel = 0.5
export(Curve) var zoom_curve
export var MAX_SPEED = 601
export var DEFAULT_SPEED = 100
export var CRASH_FORCE = 100 # how much the player slows down on impact

var move_speed = DEFAULT_SPEED
var side_movement = 0
var coins_collected = 0

func _process(_delta):
	# get player input and change their side_movement
	if Input.is_action_just_pressed("move_left") and side_movement > -30:
		side_movement -= 15
	
	if Input.is_action_just_pressed("move_right") and side_movement < 30:
		side_movement += 15

	# set the zoom level of the camera, as a function of the current speed
	var zoom_percent = (move_speed - DEFAULT_SPEED)/(MAX_SPEED-DEFAULT_SPEED)
	var zoom_amount = zoom_curve.interpolate(zoom_percent) # edit the curve in the inspector to change how much you zoom
	$CartCamera.zoom = Vector2(zoom_amount, zoom_amount)


func _physics_process(delta):
	# moves along the path by a certain speed
	path_follow.set_offset(path_follow.get_offset() + move_speed * delta) 
	if move_speed < MAX_SPEED:
		move_speed += accel
	
	# move side/side on the path (up and down on the path)
	position.y = side_movement

func collect():
	$pickupCoin1.play()
	coins_collected += 1

func collideWithObstacle():
	$CollisionEffect.play()
	position.x = position.x - 50
	if((floor(move_speed / 100)) - 2 > 0):
		$RemoteCartCamera.position.x -= 2.5 * ((floor(move_speed / 100)) - 2)
	
	#play skid animation
	$AnimationPlayer.play("skid")
	
	position.x = position.x + 50
	accel = 0.5
	move_speed = max(DEFAULT_SPEED, move_speed - CRASH_FORCE)	

var pastarea = null 

func _on_PlayerObject_area_shape_entered(_area_rid, area, _area_shape_index, _local_shape_index):
	
	if(str(area).split(":")[0].rstrip("0123456789@").lstrip("@") == "Obstacle"):
		collideWithObstacle()
	if(pastarea!=area):
		if(str(area).split(":")[0].rstrip("0123456789@").lstrip("@") == "Coin"):
			collect()
			pastarea = area 
