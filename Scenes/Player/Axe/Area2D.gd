extends Area2D

export var damage = 75

func _on_Area2D_body_entered(body):
	var mobs = get_tree().get_nodes_in_group("mobs")
	
	if mobs.bsearch(body) > 0:
		body.emit_signal("hit", damage)
