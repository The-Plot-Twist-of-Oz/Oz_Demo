extends PathFollow2D

onready var path_speed = get_parent().path_speed
onready var mob_scene = get_parent().mob_scene

func _physics_process(delta):
	offset += path_speed


func _on_Timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instance()

	# Set the mob's position to a PathFollow location.
	mob.position = position
	
	#
	mob.is_at_the_bottom = get_parent().is_at_the_bottom

	# Spawn the mob by adding it to the Main scene.
	get_parent().get_parent().add_child(mob)
