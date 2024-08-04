extends Area2D

func _on_Player_dorothy_armed(isArmed: bool):
	visible = isArmed
	monitoring = isArmed


func _on_DorothyArea_body_entered(body):
	body.queue_free()
