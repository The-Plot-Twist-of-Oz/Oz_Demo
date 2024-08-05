extends RigidBody2D

onready var target = get_parent().get_node("Player")

signal hit

export var health_point = 100

var speed = 40
var enemy_type = "fly"
var is_at_the_bottom = false
var down = Vector2.DOWN

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
	health_point -= damage
	
	if health_point < 1:
		queue_free()
