extends Area2D

export var target_scale = Vector2(2, 2)
export var scale_speed = Vector2(0.1, 0.1)
export var toxic_zone: PackedScene

var is_cleansed = false
var is_fake = false

onready var Player := get_parent().get_node("Player")

func _on_Timer_timeout():
	if scale < target_scale:
		scale += scale_speed
	elif is_fake:
		queue_free()
	else:
		var zone = toxic_zone.instance()
		
		if Player.has_meta("PsychosesSystem"):
			var Psychoses = Player.get_meta("PsychosesSystem", null)
			Psychoses.add_stress(40)
		
		zone.position = position
		zone.scale = scale
		
		get_parent().add_child(zone)
		queue_free()

func _on_CleanseTimer_timeout():
	is_cleansed = true
	Player.emit_signal("heal")
	queue_free()


func _on_Toxic_orb_body_entered(body):
	if body.name == "Player" and !is_fake:
		$CleanseTimer.start()
		$GrowTimer.stop()


func _on_Toxic_orb_body_exited(body):
	if body.name == "Player"  and !is_fake and !is_cleansed:
		$CleanseTimer.stop()
		$GrowTimer.start()
