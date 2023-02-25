extends Node2D

var numRats = 0
onready var body = $Body
onready var rats = get_tree().get_nodes_in_group("rats")
onready var ratPlayers = get_tree().get_nodes_in_group("ratPlayers")
signal end(isWin)


func _ready():
	delet_rat()
	body.frame=0

func start_game(diff):
	visible=true
	body.frame = 0
	numRats = diff
	#change diff multiplier to test difficulties
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
	
func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.is_pressed():
			$"../smapSFX".play()
			$"../RatSFX".play()
			if get_global_mouse_position().x < $pointer.position.x:
				$pouncePlayer.play("pounce left")
			else:
				$pouncePlayer.play("pounce right")
				pass
			pass

func _on_pounceClock_out():
	emit_signal("end", true)
	delet_rat()

func _on_RatPlayer_animation_finished(_anim_name):
	emit_signal("end", false)
	delet_rat()
	
func delet_rat():
	for ratPlayer in ratPlayers:
		ratPlayer.stop(true)
	$pounceClock/Timer.stop()
	visible = false
	body.stop()
	body.frame=0
	$pounceClock.value = 5
	for rat in rats:
		rat.visible = false
