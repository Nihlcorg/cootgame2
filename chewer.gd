extends Node2D

var Neededchews = 5
var chews = 0
onready var head = $Sprite/head

signal end(isWin)

func _ready():
	$derpHead.visible = false
	head.frame=0
	$Sprite.frame = 0

func start_game(diff):
	$Sprite/head.visible = true
	$Sprite.frame = 0
	$derpHead.visible = false
	visible=true
	chews = 0
	head.frame = 0
	#change diff multiplier to test difficulties
	Neededchews = diff*5
	$chewClock/Timer.start()
	
func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.is_pressed():
			if chews == Neededchews:
				$"../tearSFX".play()
				$derpHead.visible = true
				$Sprite/head.visible = false
				$Sprite.frame = 1
			else:
				$"../chewSFX".play()
				head.play("default")
				head.frame = 0
				chews +=1

func _on_chewClock_out():
	$chewClock/Timer.stop()
	if chews >= Neededchews : 
		emit_signal("end", true)
	else:  
		emit_signal("end", false)
	visible = false
	head.stop()
	head.frame=0
	chews = 0
	$chewClock.value = 5
