extends Node2D

var paw = load("res://pngs/paw.png")

var difficulty = 1
var lives = 3
onready var music = $clownMusic
onready var cootHead = $lifeplayer/lifecoot
onready var derHead = $lifeplayer/lifeder
onready var swiftHead = $lifeplayer/lifeswift
onready var games = [0, 1, 2, 3, 4]
onready var dergames = [5, 6, 7]
var gamenum = 0
var lastgame = -1
var score = -1

#needs to be semi random
func select_game():
	var num = games[gamenum]
#	num = 5
	match(num):
		0:
			$chewer.start_game(difficulty)
		1:
			$licker.start_game(difficulty)
		2:
			$Pouncer.start_game(difficulty)
		3: 
			$horker.start_game(difficulty)
		4:
			$Peeker.start_game(difficulty)
		5:
			$derLick.start_game(difficulty)
		6:
			$derPeek.start_game(difficulty)
		7:
			$derPounce.start_game(difficulty)
	lastgame = games[gamenum]
	gamenum += 1

func remove_life():
	if lives > 0: lives -=1
	#print(lives)
	match(lives):
		2:
			swiftHead.frame = 1
		1:
			derHead.frame = 1
		0: 
			cootHead.frame = 1

func add_life():
	if lives <3: lives +=1
	match(lives):
		3:
			swiftHead.frame = 0
		2:
			derHead.frame = 0
		1: 
			cootHead.frame = 0

func _ready():
	Input.set_custom_mouse_cursor(paw)
	music.pitch_scale = 0.8
	music.play()
	games.shuffle()
	$MasterPlayer.play("start")
	$retryDoor.input_pickable = false

func _on_MasterPlayer_animation_finished(anim_name):
	if anim_name == "over": 
		$MasterPlayer.play("permaloss")
		$boos.play()
	if anim_name == "lose": $boos.stop()
	else: $applause.stop()
	if lives > 0 :
		if gamenum == games.size():
			if games.size() < 8: games.append_array(dergames)
			games.shuffle()
			while lastgame == games[0]: games.shuffle()
			gamenum = 0
			if difficulty <5: 
				difficulty += 1
				music.pitch_scale += .1
			print(difficulty)
			$swift.start_game(difficulty)
		else: select_game()

func _on_MasterPlayer_animation_started(anim_name):
	score += 1
	$score.text = str(score)
	if anim_name == "win":
		$applause.play()
	elif anim_name == "lose": 
		$boos.play()

func is_game_over():
	if lives <= 0:
		return true

func _on_retryDoor_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.is_pressed():
			get_tree().reload_current_scene()
