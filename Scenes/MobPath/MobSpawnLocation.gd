extends PathFollow2D

onready var path_speed = get_parent().path_speed
onready var mob_scenes = get_parent().mob_scenes

var random = RandomNumberGenerator.new()

func _physics_process(delta):
	offset += path_speed


func _on_Timer_timeout():
	# Create a new instance of the Mob scene.
	random.randomize()
	var rng = random.randi_range(0, mob_scenes.size()-1)
	var mob = mob_scenes[rng].instance()

	# Set the mob's position to a PathFollow location.
	mob.position = position
	
	#
	if mob.name != "Monkey":
		mob.is_at_the_bottom = get_parent().is_at_the_bottom

	# Spawn the mob by adding it to the Main scene.
	get_parent().get_parent().add_child(mob)
