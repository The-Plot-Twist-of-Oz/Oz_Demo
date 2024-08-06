extends VBoxContainer

export var controlMenu: PackedScene
export var creditsMenu: PackedScene
export var level1: PackedScene

func _on_ControlButton_pressed():
	get_tree().change_scene_to(controlMenu)


func _on_CreditsButton_pressed():
	get_tree().change_scene_to(creditsMenu)


func _on_StartButton_pressed():
	AutoLoad.get_node("Intro").stop()
	AutoLoad.get_node("Intro").isPlayed = false
	get_tree().change_scene_to(level1)
