extends Control

export var path = "res://Scenes/MainMenu/MainMenu.tscn" 

func _ready():
	if !AutoLoad.get_node("Intro").isPlayed:
		AutoLoad.get_node("Intro").play()
		AutoLoad.get_node("Intro").isPlayed = true

func _on_Button_pressed():
	get_tree().change_scene(path)
