extends Node2D


export var speed := 40


func _ready():
	owner.set_meta("movment_component", self)
	

func _exit_tree():
	owner.remove_meta("movment_component")
	

func follow(target: Node):
	owner.linear_velocity = target.position - owner.position
	

func walk_to(direct: Vector2):
	owner.linear_velocity = direct * speed
	

func walk_to_with_rotation(direct: Vector2, rotation: float):
	owner.linear_velocity = direct.rotated(rotation) * speed
	
