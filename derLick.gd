extends Node2D

var lost = false
signal end(isWin)
var limit = 100

func _on_nonoZone_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseMotion:
		if event.speed.abs() > Vector2(limit, limit):
				#print(event.speed)
				$"../MrowSFX".play()
				lost = true
				$ders.frame = 1

func start_game(_diff):
	lost = false
	visible=true
	$ders.frame = 0
	$derlickClock/Timer.start()

func _on_derlickClock_out():
	if lost: emit_signal("end", false)
	else: emit_signal("end", true)
	$derlickClock/Timer.stop()
	$derlickClock.value = 3
	visible = false
	
