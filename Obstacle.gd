extends Area2D

export (PackedScene) var obstacle_decoy # created when this is hit

# called by the player on collision
func on_hit():
	# use a new rigidbody to fly off the screen
	var new_decoy = obstacle_decoy.instance()
	new_decoy.position = position
	new_decoy.rotation = rotation
	new_decoy.linear_velocity = Vector2(cos(rotation), sin(rotation)) * 400
	get_node("/root").call_deferred("add_child", new_decoy)
	
	# remove this
	queue_free()

func _on_Obstacle_area_shape_entered(_area_rid:RID, area:Area2D, _area_shape_index:int, _local_shape_index:int):
	if ("Player" in str(area)):
		# a player collided with this
		on_hit()
