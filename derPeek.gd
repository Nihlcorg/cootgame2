extends Node2D

onready var body = $curtain
var limit = 100
var lost = false

signal end(isWin)

func _ready():
	body.frame=0

func start_game(_diff):
	lost = false
	visible=true
	body.frame = 0
	$ders.frame = 0
	$ders.visible = false
	$peekClock/Timer.start()
	start_rats()

func start_rats():
	$PinchPlayer.play("derhand1")

func _on_peekClock_out():
	if lost : emit_signal("end", false)
	else : emit_signal("end", true)
	$peekClock/Timer.stop()
	visible = false
	body.stop()
	body.frame=0
	$peekClock.value = 3
	$PinchPlayer.stop(true)
	$PinchPlayer.seek(0, true)
	$ders.visible = false

func _on_RatPlayer_animation_finished(_anim_name):
	#stop all pinch players
	$PinchPlayer.stop(true)
	$peekClock.value = 2

func _on_nonoZone_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseMotion:
		if event.speed.abs() > Vector2(limit, limit):
				#print(event.speed)
				lost = true
				$"../MrowSFX".play()
				$ders.frame = 1
