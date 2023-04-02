extends Area2D

func _on_Coin_area_entered(_area):
	queue_free()
