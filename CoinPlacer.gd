extends PathFollow2D

export (PackedScene) var Coin_scene

export var total_coins = 500
export var spawner_seed = "200"

func _ready():
	seed(spawner_seed.hash())
	for _i in range(total_coins):
		place_coin(randf(), 15 * ((randi() % 4)-2))

func place_coin(offset, lane):
	# move along the path to the given position
	set_unit_offset(offset)
	# spawn the obstacle, but dont parent it to this
	var coin = Coin_scene.instance() 
	get_node("/root").call_deferred("add_child", coin) # error handler told me to use call_deferred, fixed everything, idk why
	coin.position = position + (lane * Vector2(cos(rotation + PI/2), sin(rotation + PI/2))) #YAYY
	coin.rotation = rotation
	#todo: Make respawn if spawned on obstacle


