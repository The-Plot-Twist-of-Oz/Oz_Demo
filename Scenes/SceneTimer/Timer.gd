extends Timer

export var next_level: PackedScene

func _on_Timer_timeout():
	get_tree().change_scene_to(next_level)
