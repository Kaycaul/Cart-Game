extends Sprite

onready var path_follow = get_parent() # gets the parent (which should be a path follower) to move the player

export var move_speed = 1

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
	
	# move side/side on the path (up and down on the path)
	position.y = side_movement

