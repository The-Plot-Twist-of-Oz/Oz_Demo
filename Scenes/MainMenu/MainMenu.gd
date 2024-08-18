extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var texture_manager = TextureManager.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	var trophyList: Dictionary = yield(GameJolt.trophies_fetch(), "trophies_fetch_completed")
	
	for i in trophyList["trophies"]:
		var texture = texture_manager.NewTextureFromURL(i["image_url"])
		$ItemList.add_item(i["description"], texture)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
