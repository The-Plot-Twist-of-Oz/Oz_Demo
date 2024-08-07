extends Area2D

export var target_scale = Vector2(2, 2)
export var scale_speed = Vector2(0.1, 0.1)
export var toxic_zone: PackedScene

var isCleansed = false


func _on_Timer_timeout():
	if scale < target_scale:
		scale += scale_speed
	else:
		var zone = toxic_zone.instance()
		
		zone.position = position
		zone.scale = scale
		
		get_parent().add_child(zone)
		queue_free()

func _on_CleanseTimer_timeout():
	isCleansed = true
	get_parent().get_node("Player").emit_signal("heal")
	queue_free()


func _on_Toxic_orb_body_entered(body):
	if body.name == "Player":
		$CleanseTimer.start()
		$GrowTimer.stop()


func _on_Toxic_orb_body_exited(body):
	if body.name == "Player" and !isCleansed:
		$CleanseTimer.stop()
		$GrowTimer.start()
