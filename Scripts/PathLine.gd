extends Line2D

# draws a visible line over the path that the player follows
onready var parent_path = get_parent()

func _ready():
	# iterate over every point in the invisible player path
	for point in parent_path.curve.get_baked_points():
		add_point(point + position) # points are relative to the paths location, so add position



func _on_EndOfLevel5BadArea2D_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	pass # Replace with function body.
