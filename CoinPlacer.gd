extends PathFollow2D

export (PackedScene) var Coin_scene

export var total_coins = 5

func _ready():
	spawn_coins()

func spawn_coins():
	for i in range(total_coins):
		var coin = Coin_scene.instance() 
		add_child(coin) 
		coin.position.x = 190 + (i*30)
		coin.position.y = -10 + (i*-30)
		#Make respawn if spawned on obstacle


