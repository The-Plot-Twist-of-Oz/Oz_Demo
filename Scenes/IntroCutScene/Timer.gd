extends Timer

var level1 = preload("res://Scenes/Main/Main.tscn")

func _on_Timer_timeout():
	get_tree().change_scene_to(level1)
