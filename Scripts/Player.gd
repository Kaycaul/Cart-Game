extends Area2D

onready var path_follow = get_parent() # gets the parent (which should be a path follower) to move the player

export var accel = 0.5
export(Curve) var zoom_curve
export(Curve) var intro_zoom_curve
export var MAX_SPEED = 601
export var DEFAULT_SPEED = 0
export var CRASH_FORCE = 100 # how much the player slows down on impact
export var INTRO_WAIT_TIME = 3 # seconds until the player can move at the start of each level

var global

var immune = false
var immuneTime = 0
var move_speed = DEFAULT_SPEED
var side_movement = 0
var desired_side_movement = 0;
var coins_collected = 0
var time = 0
var waiting_to_start = true

var timer # a 2 second timer at the start of each level

func _ready():
	global = get_node("/root/Global")
	update_coin_hud(global.totalNickels)
	# move forward a little bit
	path_follow.set_offset(path_follow.get_offset() + 35) 
	# create a 2 second timer
	timer = Timer.new()
	self.add_child(timer)
	timer.set_one_shot(true)
	timer.start(2)
	yield(timer, "timeout")
	timer.queue_free()
	# when the timer stops, allow the player to move
	waiting_to_start = false
	move_speed = 0

func _process(_delta):
	# get player input and change their desired_side_movement
	if Input.is_action_just_pressed("move_left") and desired_side_movement > -30:
		desired_side_movement -= 15
	
	if Input.is_action_just_pressed("move_right") and desired_side_movement < 30:
		desired_side_movement += 15

	var zoom_amount
	if waiting_to_start:
		# set the zoom level of the camera as a function of the time until the player can move
		var zoom_percent = timer.time_left/2
		zoom_amount = intro_zoom_curve.interpolate(zoom_percent)	
	else:
		# set the zoom level of the camera, as a function of the current speed
		var zoom_percent = (move_speed - DEFAULT_SPEED)/(MAX_SPEED-DEFAULT_SPEED)
		zoom_amount = zoom_curve.interpolate(zoom_percent) # edit the curve in the inspector to change how much you zoom
		
	$CartCamera.zoom = Vector2(zoom_amount, zoom_amount)

func _physics_process(delta):
	# move side/side on the path (up and down on the path)
	if abs(desired_side_movement - side_movement) < 1:
		# you are close enough
		side_movement = desired_side_movement
	else:
		# move closer to the desired side movement
		side_movement = lerp(side_movement, desired_side_movement, 0.5)
	position.y = side_movement
	$CanvasLayer/HUD/SpeedLabel2.text = str(floor(move_speed))

	# ignore the remaining code if the level has not started yet
	if waiting_to_start:
		return
	
	# moves along the path by a certain speed
	path_follow.set_offset(path_follow.get_offset() + move_speed * delta) 
	if move_speed < MAX_SPEED:
		move_speed += accel
	# accelerate even more at the start
	if move_speed < DEFAULT_SPEED:
		move_speed += 4*accel
	
	if immune && immuneTime + 2 == get_node("/root/Global").levelTime : 
		immune = false

func collect():
	$pickupCoin1.play()
	global.totalNickels += 1
	update_coin_hud(global.totalNickels)

func update_coin_hud(number_of_nickels):
	$CanvasLayer/CoinHUD/CoinLabel.text = "$%.2f" % (number_of_nickels * 0.05)


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
	
	if(str(area).split(":")[0].rstrip("0123456789@").lstrip("@") == "Obstacle" && !immune):
		collideWithObstacle()
		immuneTime = get_node("/root/Global").levelTime
		immune = true
		
	if(pastarea!=area):
		if(str(area).split(":")[0].rstrip("0123456789@").lstrip("@") == "Coin"):
			collect()
			pastarea = area 
