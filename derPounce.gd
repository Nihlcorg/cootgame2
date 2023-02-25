extends Node2D

var numRats = 0
var limit = 100
var lost = false
onready var rats = get_tree().get_nodes_in_group("rats")
onready var ratPlayers = get_tree().get_nodes_in_group("ratPlayers")

signal end(isWin)

func _ready():
	delet_rat()

func start_game(diff):
	$ders.frame = 0
	lost = false
	visible=true
	numRats = diff
	$pounceClock/Timer.start()
	start_rats()
	
func start_rats():
	match(numRats):
		1:
			$RatPlayer.play("rat1")
		2:
			$RatPlayer.play("rat1")
			$RatPlayer2.play("rat2")
		3:
			$RatPlayer.play("rat1")
			$RatPlayer2.play("rat2")
			$RatPlayer3.play("rat3")
		4:
			$RatPlayer.play("rat1")
			$RatPlayer2.play("rat2")
			$RatPlayer3.play("rat3")
			$RatPlayer4.play("rat4")
		5:
			$RatPlayer.play("rat1")
			$RatPlayer2.play("rat2")
			$RatPlayer3.play("rat3")
			$RatPlayer4.play("rat4")
			$RatPlayer5.play("rat5")

func _on_pounceClock_out():
	if lost: emit_signal("end", false)
	else: emit_signal("end", true)
	$pounceClock/Timer.stop()
	$pounceClock.value = 4.5
	visible = false
	delet_rat()

func delet_rat():
	for ratPlayer in ratPlayers:
		ratPlayer.stop(true)
	$pounceClock/Timer.stop()
	visible = false
	$pounceClock.value = 4.5
	for rat in rats:
		rat.visible = false

func _on_nonoZone_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseMotion:
		if event.speed.abs() > Vector2(limit, limit):
				#print(event.speed)
				$"../MrowSFX".play()
				lost = true
				$ders.frame = 1
