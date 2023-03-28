extends PathFollow2D

export (PackedScene) var obstacle_to_spawn
export var obstacle_count = 5
export var spawner_seed = "200"

func _ready():
	seed(spawner_seed.hash())
	for _i in range(obstacle_count):
		spawn_obstacle(randf(), 20 * ((randi() % 5)-2))

func spawn_obstacle(offset, lane):
	# move along the path to the given position
	set_unit_offset(offset)
	# spawn the obstacle, but dont parent it to this
	var obstacle = obstacle_to_spawn.instance()
	get_node("/root").call_deferred("add_child", obstacle) # error handler told me to use call_deferred, fixed everything, idk why
	print("position ", position)
	obstacle.position = position + (lane * Vector2.RIGHT)
	print("lane ", lane)
	print("after ", obstacle.position)
	print(" ")
	obstacle.rotation = rotation
