extends Label

func _ready():
	var player = get_node("/root/Root/PlayerPath/PlayerPathFollow/PlayerObject")
	player.connect("coins_collected_updated", self, "_on_coins_collected_updated")
	print("Signal connected to", self, "from", player)
	text = str(1)

func _on_coins_collected_updated(coins):
	text = str(coins)
	print("hi")
	

