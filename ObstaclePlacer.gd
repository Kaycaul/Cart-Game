extends PathFollow2D

export (PackedScene) var obstacle_to_spawn

func _ready():
	# test
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	for i in range(100):
		spawn_obstacle(100 * i, 15 * rng.randi_range(-2,2))

func spawn_obstacle(offset, lane):
	# move along the path to the given position
	set_offset(offset)
	# spawn the obstacle, but dont parent it to this
	var obstacle = obstacle_to_spawn.instance()
	get_node("/root").call_deferred("add_child", obstacle) # error handler told me to use call_deferred, fixed everything, idk why
	obstacle.position = position + (lane * Vector2.DOWN)
	obstacle.rotation = rotation
	print("spawned obstacle at " + str(position))
