extends KinematicBody2D

signal hit
signal dorothy_armed
signal tin_man_armed
signal heal

export var speed = 250 # How fast the player will move (pixels/sec).
export(Array, SpriteFrames) var characters
export(Array, Texture) var characters_texture

var screen_size # Size of the game window.
var nextChar = 0
var cool_down = false


func _ready():
	#$PsychosesSystem.add_psychoses()
	screen_size = get_viewport_rect().size
	hide()


func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()

	move_and_slide(velocity)
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

	if velocity.x != 0 and nextChar != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
	
	if Input.is_action_pressed("swap_characters") and !cool_down:
		cool_down = true
		character_swap()
		$SwitchCD.start()


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
	

func character_swap():
	$AnimatedSprite.frames = characters[nextChar]
	$Trail.texture = characters_texture[nextChar]
		
		
	if nextChar == 0:
		emit_signal("dorothy_armed", false)
		emit_signal("tin_man_armed", true)
		$TinManSwap.play()
	elif nextChar == 1:
		$LionSwap.play()
		emit_signal("tin_man_armed", false)
		speed += 400
	elif nextChar == 2:
		speed -= 400
		$DorothySwap.play()
		emit_signal("dorothy_armed", true)
	
	
	nextChar += 1
	if nextChar > 2:
		nextChar = 0


func play_death():
	match nextChar:
		0:
			$DorothyDeath.play()
		1:
			$TinManDeath.play()
		2:
			$LionDeath.play()

func play_hit():
	match nextChar:
		0:
			if $DorothyHit.is_playing() == false:
				$DorothyHit.play()
		1:
			if $TinManHit.is_playing() == false:
				$TinManHit.play()
		2:
			if $LionHit.is_playing() == false:
				$LionHit.play()


func _on_Area2D_body_entered(body):
	if body.get_groups().has("mobs"):
		emit_signal("hit")


func _on_SwitchCD_timeout():
	cool_down = false
