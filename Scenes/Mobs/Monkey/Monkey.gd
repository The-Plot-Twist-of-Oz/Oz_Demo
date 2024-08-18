extends RigidBody2D

export(Array, AudioStream) var sounds

onready var target = get_parent().get_node("Player")
onready var audio = get_node("AudioStreamPlayer2D")

var health_component
var movment_component

signal hit
var mob_hit = false

var random = RandomNumberGenerator.new()

func _ready():
	$AnimatedSprite.playing = true
	
	if has_meta("health_component"):
		health_component = get_component("health_component")
	
	if has_meta("movment_component"):
		movment_component = get_component("movment_component")
	

func _physics_process(delta):
	movment_component.follow(target)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Mob_hit(damage):
	if mob_hit == false:
		mob_hit = true
		random.randomize()
		var rng = random.randi_range(0, sounds.size()-1)
		audio.stream = sounds[rng]
		audio.play()
	
	health_component.change_health(damage)
	
		
func get_component(component: String) -> Node:
	return get_meta(component, null)
