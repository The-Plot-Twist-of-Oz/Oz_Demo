extends Node

var score
var health
export var toxic_orb: PackedScene

func _ready():
	randomize()


func game_over():
	get_tree().call_group("mobs", "queue_free")
	get_tree().call_group("orbs", "queue_free")
	$HUD.update_health("Game Over")
	$OrbTimer.stop()
	$MobPath1/Timer.stop()
	$MobPath2/Timer.stop()
	$ScoreTimer.stop()
	$HUD.show_game_over()
	$Player.hide()
	$Music.stop()
	$Player.play_death()

func new_game():
	score = 0
	health = 10
	$MobPath1/Timer.start()
	$MobPath2/Timer.start()
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$OrbTimer.start()
	$HUD.update_score(score)
	$HUD.update_health(health)
	$HUD.show_message("Get Ready")
	$Music.play()
	

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_StartTimer_timeout():
	$ScoreTimer.start()

func _on_Player_hit():
	health -= 1
	$HUD.update_health(health)
	$Player.play_hit()
	if health < 0:
		game_over()


func _on_OrbTimer_timeout():
	var orb = toxic_orb.instance()
	
	orb.position = Vector2(rand_range(192, 1728), rand_range(192, 888))
	
	add_child(orb)


func _on_Area2D_area_entered(area):
	if area.name == "Player":
		area.speed += 150


func _on_Area2D_area_exited(area):
	if area.name == "Player":
		area.speed -= 150


func _on_Player_heal():
	if health < 10:
		health += 1
		$HUD.update_health(health)
