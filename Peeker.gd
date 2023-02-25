extends Node2D

var numRats = 0
onready var body = $curtain
onready var rats = get_tree().get_nodes_in_group("rats")
onready var pinchPlayers = get_tree().get_nodes_in_group("pinchPlayers")
var lost = false

signal end(isWin)

func _process(_delta):
	if lost: body.frame = 1

func _ready():
	body.frame=0

func start_game(diff):
	visible=true
	lost = false
	body.frame = 0
	numRats = diff
	#change diff multiplier to test difficulties
	$peekClock/Timer.start()
	start_rats()

func start_rats():
	match(numRats):
		1:
			$PinchPlayer.play("hand1")
		2:
			$PinchPlayer.play("hand1")
			$PinchPlayer2.play("hand2")
		3:
			$PinchPlayer.play("hand1")
			$PinchPlayer2.play("hand2")
			$PinchPlayer3.play("hand3")
		4:
			$PinchPlayer.play("hand1")
			$PinchPlayer2.play("hand2")
			$PinchPlayer3.play("hand3")
			$PinchPlayer4.play("hand4")
		5:
			$PinchPlayer.play("hand1")
			$PinchPlayer2.play("hand2")
			$PinchPlayer3.play("hand3")
			$PinchPlayer4.play("hand4")

func _on_peekClock_out():
	if lost : emit_signal("end", false)
	else : emit_signal("end", true)
	$peekClock/Timer.stop()
	visible = false
	body.stop()
	body.frame=0
	$peekClock.value = 5
	delet_pinch()
	
func _on_RatPlayer_animation_finished(_anim_name):
	$"../mewSFX".play()
	body.frame = 1
	lost = true
	delet_pinch()
	
func delet_pinch():
	for pinchPlayer in pinchPlayers:
		pinchPlayer.stop(true)
		pinchPlayer.lost = false
	for rat in rats:
		rat.visible = false
