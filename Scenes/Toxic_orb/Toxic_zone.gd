extends Area2D


func _on_Toxic_zone_body_entered(body):
	if body.name == "Player":
		body.get_parent().game_over()
