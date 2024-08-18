class_name TrophyManager
extends Reference

signal trophies_ready

func GetTrophies():
	var trophyList: Dictionary = yield(GameJolt.trophies_fetch(), "trophies_fetch_completed")
	emit_signal("trophies_ready", trophyList)

func GetTrophy(id: String) -> Dictionary:
	var trophy: Dictionary = yield(GameJolt.trophies_fetch(null, [id]), "trophies_fetch_completed")
	return trophy
