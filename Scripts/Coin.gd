extends Area2D

func _on_Coin_area_entered(area):
	queue_free()
