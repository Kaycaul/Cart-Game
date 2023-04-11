extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$CanvasLayer/CoinHUD/CoinLabel.text = "$%.2f" % (get_node("/root/Global").totalNickels * 0.05)
