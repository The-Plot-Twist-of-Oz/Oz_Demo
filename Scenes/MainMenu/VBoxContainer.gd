extends VBoxContainer

export var controlMenu: PackedScene
export var creditsMenu: PackedScene
export var level1: PackedScene

func _on_ControlButton_pressed():
	get_tree().change_scene_to(controlMenu)


func _on_CreditsButton_pressed():
	get_tree().change_scene_to(creditsMenu)


func _on_StartButton_pressed():
	get_tree().change_scene_to(level1)
