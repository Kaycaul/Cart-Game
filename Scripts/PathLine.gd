extends Line2D

# draws a visible line over the path that the player follows
onready var parent_path = get_parent()

func _ready():
	# iterate over every point in the invisible player path
	$Timer.start()
	for point in parent_path.curve.get_baked_points():
		add_point(point + position) # points are relative to the paths location, so add position

