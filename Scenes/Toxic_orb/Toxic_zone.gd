extends Area2D


func _on_Toxic_zone_area_entered(area):
	if area.name == "Player":
		area.get_parent().game_over()


func _on_Timer_timeout():
	pass
