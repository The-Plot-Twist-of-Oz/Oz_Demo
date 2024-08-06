extends RigidBody2D

onready var target = get_parent().get_node("Player")

signal hit



var speed = 40
var enemy_type = "fly"
var is_at_the_bottom = false
var down = Vector2.DOWN

var given_score = {"fly": 5, "walk": 10, "swim": 15}
var health_point = 100
var HP_dict = {"fly": 75, "walk": 100, "swim": 150}

var mob_hit = false

var random = RandomNumberGenerator.new()

func _ready():
	$AnimatedSprite.playing = true
	var mob_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]
	enemy_type = $AnimatedSprite.animation
	
	if enemy_type == "walk":
		rotation += rand_range(-PI / 4, PI / 4)
	elif enemy_type == "fly":
		collision_mask = 2
		collision_layer = 2
	
	health_point = HP_dict[enemy_type]
	
	if is_at_the_bottom:
		down = Vector2.UP
	

func _physics_process(delta):
	if enemy_type == "fly":
		linear_velocity = target.position - position
	elif enemy_type == "swim":
		linear_velocity = down * speed
	else:
		linear_velocity = down.rotated(rotation) * speed

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Mob_hit(damage):
	random.randomize()
	health_point -= damage
	
	var rng = random.randi_range(0, 6)
	
#	TODO: If we end up developing this game past the 2D Mini Game Jam,
#	this Yandere Dev-esque BS will be the first thing I'll fix.
#	Promise!
	match enemy_type:
		"walk":
			match rng:
				0:
					if mob_hit == false:
						$"Zombie_Growl-1".play()
				1:
					if mob_hit == false:
						$"Zombie_Growl-2".play()
				2:
					if mob_hit == false:
						mob_hit = true
						$"Zombie_Growl-3".play()
				3:
					if mob_hit == false:
						mob_hit = true
						$"Zombie_Growl-4".play()
				4:
					if mob_hit == false:
						$"Zombie_Ouch-1".play()
				5:
					if mob_hit == false:
						mob_hit = true
						$"Zombie_Ouch-2".play()
				6:
					if mob_hit == false:
						mob_hit = true
						$"Zombie_Ouch-3".play()
		"fly":
			match rng:
				0:
					if mob_hit == false:
						mob_hit = true
						$"Monkey_Scream-1".play()
				1:
					if mob_hit == false:
						mob_hit = true
						$"Monkey_Scream-2".play()
				2:
					if mob_hit == false:
						mob_hit = true
						$"Monkey_Scream-3".play()
				3:
					if mob_hit == false:
						mob_hit = true
						$"Monkey_Scream-4".play()
				4:
					if mob_hit == false:
						mob_hit = true
						$"Monkey_Scream-5".play()
				5:
					if mob_hit == false:
						mob_hit = true
						$"Monkey_Scream-6".play()
				6:
					if mob_hit == false:
						mob_hit = true
						$"Monkey_Scream-4".play()
		"swim":
			match rng:
				0:
					if mob_hit == false:
						mob_hit = true
						$"Zombie_Growl-1".play()
				1:
					if mob_hit == false:
						mob_hit = true
						$"Zombie_Growl-2".play()
				2:
					if mob_hit == false:
						mob_hit = true
						$"Zombie_Growl-3".play()
				3:
					if mob_hit == false:
						mob_hit = true
						$"Zombie_Growl-4".play()
				4:
					if mob_hit == false:
						$"Zombie_Ouch-1".play()
				5:
					if mob_hit == false:
						mob_hit = true
						$"Zombie_Ouch-2".play()
				6:
					if mob_hit == false:
						mob_hit = true
						$"Zombie_Ouch-3".play()
	print(health_point)
	if health_point < 1:
		get_parent().add_score(given_score[enemy_type])
		queue_free()
