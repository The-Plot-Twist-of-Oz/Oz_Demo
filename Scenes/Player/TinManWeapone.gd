extends AnimatedSprite

export var axe: PackedScene
export var speed = 50
export var angular_speed = 10
var isArmed = false

func _on_Player_tin_man_armed(isTinManArmed: bool):
	isArmed = isTinManArmed
	visible = isArmed
	
	if isArmed:
		_on_Timer_timeout()
		$Timer.start()
	else:
		$Timer.stop()


func _on_Timer_timeout():
	var axe1 = axe.instance()
	var axe2 = axe.instance()
	
	axe1.position = get_parent().position
	axe2.position = get_parent().position
	
	axe1.linear_velocity = Vector2.RIGHT * speed
	axe2.linear_velocity = Vector2.LEFT * speed
	
	axe1.angular_velocity = angular_speed
	axe2.angular_velocity = angular_speed
	
	get_parent().get_parent().add_child(axe1)
	get_parent().get_parent().add_child(axe2)
	
