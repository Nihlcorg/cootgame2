extends Node2D

var Neededhorks = 5
var horks = 0
onready var coot = $coot

signal end(isWin)

func _ready():
	coot.frame=0

func start_game(diff):
	visible=true
	horks = 0
	coot.frame = 0
	#change diff multiplier to test difficulties
	Neededhorks = diff*6
	$horkClock/Timer.start()
	
func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.is_pressed():
			coot.play("default")
			coot.frame = 0
			horks +=1
			if !$"../horkSFX".playing: $"../horkSFX".play()
			if horks == Neededhorks: 
				$"../ptooeySFX".play()
				$hairPlayer.play("hairball")
				pass

func _on_horkClock_out():
	$horkClock/Timer.stop()
	if horks >= Neededhorks : 
		emit_signal("end", true)
	else:  
		emit_signal("end", false)
	visible = false
	coot.stop()
	coot.frame=0
	horks = 0
	$horkClock.value = 5
