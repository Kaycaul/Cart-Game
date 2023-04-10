extends PathFollow2D

onready var parent_path = get_parent()

export (PackedScene) var path_part

# spawns a path part everywhere on the path
func _ready():
	var i = 0
	for point in parent_path.curve.get_baked_length():
		# move along the path to the given position
		set_offset(i)
		var obstacle = path_part.instance()
		# spawn the obstacle, but dont parent it to this
		get_node("/root").call_deferred("add_child", obstacle) # error handler told me to use call_deferred, fixed everything, idk why
		obstacle.position = position
		obstacle.rotation = rotation
		obstacle.z_index = -1
		i += parent_path.curve.bake_interval
