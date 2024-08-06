extends CanvasLayer

signal start_game


func show_message(text):
	$GameTitle.text = text
	$GameTitle.show()
	$MessageTimer.start()


func show_game_over():
	show_message("Game Over")
	yield($MessageTimer, "timeout")
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()


func update_score(score):
	$ScoreMeter.text = str(score)

func update_health(health):
	$HealthMeter.text = str(health)

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")


func _on_MessageTimer_timeout():
	$GameTitle.hide()

