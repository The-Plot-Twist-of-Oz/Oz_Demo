extends RigidBody2D

onready var target = get_parent().get_node("Player")
var speed = 0
var enemy_type = { "fly" : 1, "swim" : 0.5, "walk" : 0.75}

func _ready():
	$AnimatedSprite.playing = true
	var mob_types = $AnimatedSprite.frames.get_animation_names()
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()]
	speed = enemy_type[$AnimatedSprite.animation]

func _physics_process(delta):
	linear_velocity = (target.position - position) * speed

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
