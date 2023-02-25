extends Node2D

var pet = false
signal end(isWin)

func _ready():
	visible = false

func start_game(_diff):
	pet = false
	visible=true
	$body/head.frame = 0
	$hearts.visible = false
	$body.frame = 0
	$peekClock.value = 5
	
	$peekClock/Timer.start()

func _on_Area2D_input_event(viewport, event, shape_idx):
#	dog pet
	$body/head.frame = 1
	$body.play("default")
	$hearts.visible = true
	$pantSFX.play()
	pet = true

func _on_peekClock_out():
	$peekClock/Timer.stop()
	$body.stop()
	$pantSFX.stop()
	emit_signal("end", pet)
	visible = false
