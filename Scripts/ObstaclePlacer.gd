extends PathFollow2D

export (Array, PackedScene) var obstacles_to_spawn
export var obstacle_count = 5
export var spawner_seed = "200"

func _ready():
	seed(spawner_seed.hash())
	for _i in range(obstacle_count):
		spawn_obstacle(randf(), 15 * ((randi() % 5)-2))

func spawn_obstacle(offset, lane):
	# move along the path to the given position
	set_unit_offset(offset)
	# choose a random obstacle
	obstacles_to_spawn.shuffle()
	var obstacle = obstacles_to_spawn[0].instance()
	# spawn the obstacle, but dont parent it to this
	get_node("/root").call_deferred("add_child", obstacle) # error handler told me to use call_deferred, fixed everything, idk why
	obstacle.position = position + (lane * Vector2(cos(rotation + PI/2), sin(rotation + PI/2))) #YAYY
	obstacle.rotation = rotation
