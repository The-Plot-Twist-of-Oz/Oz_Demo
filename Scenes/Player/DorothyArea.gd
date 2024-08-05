extends Area2D

export var damage = 25

func _on_Player_dorothy_armed(isArmed: bool):
	visible = isArmed
	monitoring = isArmed


func _on_DorothyArea_body_entered(body):
	body.add_to_group("InArea")
	
	if get_tree().get_nodes_in_group("InArea").size() > 0 and $Timer.is_stopped():
		$Timer.start()


func _on_DorothyArea_body_exited(body):
	body.remove_from_group("InArea")
	
	if get_tree().get_nodes_in_group("InArea").size() == 0 and !$Timer.is_stopped():
		$Timer.stop()


func _on_Timer_timeout():
	for mobs in get_tree().get_nodes_in_group("InArea"):
		mobs.emit_signal("hit", damage)
