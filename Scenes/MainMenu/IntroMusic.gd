extends AudioStreamPlayer

var isPlayed = true

func _on_AudioStreamPlayer_finished():
	if isPlayed:
		play()
