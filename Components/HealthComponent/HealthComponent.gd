extends Node2D

export var max_health := 10
export var score := 10

var current_health


# Called when the node enters the scene tree for the first time.
func _ready():
	owner.set_meta("health_component", self)
	current_health = max_health
	
func _exit_tree():
	owner.remove_meta("health_component")

func change_health(number: int):
	current_health += number
	
	if current_health < 1:
		owner.get_parent().add_score(score)
		owner.queue_free()
