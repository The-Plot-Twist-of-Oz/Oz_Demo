extends Control

export var path = "res://Scenes/MainMenu/MainMenu.tscn" 

func _on_Button_pressed():
	get_tree().change_scene(path)
