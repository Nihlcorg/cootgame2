extends Node2D

var face = load("res://pngs/3face.png")
var paw = load("res://pngs/paw.png")

onready var drops = get_tree().get_nodes_in_group("drops")
onready var body = $body
onready var words = $words
var phase = "lick"
var isBroken = false

var lickDelay = 2
var canLick = true
var numDrops = 3
signal end(isWin)

func _ready():
	body.frame=0

func start_game(diff):
	$glassPlayer.set_current_animation("smackGlass")
	$glassPlayer.stop()
	$glassPlayer.seek(0, true)
	Input.set_custom_mouse_cursor(face)
	words.frame = 0
	body.frame = 0
	visible=true
	numDrops *= diff
	add_drops()
	$lickClock/Timer.start()

func add_drops():
	for drop in drops:
		drop.visible = true
		numDrops -= 1
		if numDrops == 0: 
			numDrops = 3
			return

func remove_drops():
	for drop in drops:
		if drop.visible:
			$"../LickSFX".play()
			drop.visible = false
			return
	words.frame = 1
	phase = "smack"
	Input.set_custom_mouse_cursor(paw)

func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseMotion and phase == "lick":
		#lick a droplet
		if canLick:
			canLick = false
			lickDelay = 4
			remove_drops()
	if event is InputEventMouseButton and phase == "smack":
		if event.button_index == BUTTON_LEFT:
			#push glass
			$"../GlassSFX".play()
			body.play("default")
			$Wator.visible = false
			$Broken.visible = true
			isBroken = true
			$glassPlayer.play("smackGlass")

func _on_lickClock_out():
	$lickClock/Timer.stop()
	$lickClock.value = 5
	if isBroken : 
		emit_signal("end", true)
	else:  
		emit_signal("end", false)
	visible = false
	body.stop()
	$Wator.visible = true
	$Broken.visible = false
	Input.set_custom_mouse_cursor(paw)
	isBroken = false
	phase = "lick"

func _on_Timer_timeout():
	lickDelay -= 1
	if lickDelay == 0:
		canLick = true

func _on_body_animation_finished():
	body.stop()
	body.frame = 0

func _on_glassPlayer_animation_finished(_anim_name):
	$glassPlayer.stop()
