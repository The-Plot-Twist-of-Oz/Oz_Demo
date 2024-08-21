class_name PsychosesSystem
extends Node

export var max_stress := 100
export(Array, PackedScene) var psychoses

var curent_stress := 0

var random = RandomNumberGenerator.new()

func _ready():
	owner.set_meta("PsychosesSystem", self)

func add_stress(count: int):
	curent_stress += count
	
	if curent_stress > max_stress and !psychoses.empty():
		add_psychoses()

func add_psychoses():
	random.randomize()
	var rng = random.randi_range(0, psychoses.size()-1)
	
	var psychos = psychoses[rng].instance()
	owner.add_child(psychos)
	psychoses.remove(rng)
