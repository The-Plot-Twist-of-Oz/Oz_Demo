extends Node

var score
var health

func _ready():
	randomize()


func game_over():
	$ScoreTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()

func new_game():
	get_tree().call_group("mobs", "queue_free")
	score = 0
	health = 10
	$MobPath1/Timer.start()
	$MobPath2/Timer.start()
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
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
	if health < 0:
		$HUD.update_health("Game Over")


func _on_OrbTimer_timeout():
	pass # Replace with function body.


func _on_Area2D_body_exited(body):
	if body.name == "Player":
		body.speed -= 100


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.speed += 100
