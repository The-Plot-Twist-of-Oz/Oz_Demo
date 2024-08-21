extends Node

export var fake_orb: PackedScene

func _ready():
	get_parent().get_parent().get_node("OrbTimer").connect("timeout", self, "_on_timeout")
	get_parent().set_meta("Hopless", self)
	
func _exit_tree():
	get_parent().remove_meta("Hopless")
	

func _on_timeout():
	var orb1 = fake_orb.instance()
	var orb2 = fake_orb.instance()
	
	orb1.position = Vector2(rand_range(192, 1728), rand_range(192, 888))
	orb1.is_fake = true
	
	orb2.position = Vector2(rand_range(192, 1728), rand_range(192, 888))
	orb2.is_fake = true
	
	get_parent().get_parent().add_child(orb1)
	get_parent().get_parent().add_child(orb2)
