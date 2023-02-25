extends AnimationPlayer

func _on_chewer_end(win):
	if win : play("win")
	else : lose()

func _on_licker_end(isWin):
	if isWin : play("win")
	else :lose()

func _on_Pouncer_end(isWin):
	if isWin : play("win")
	else :lose()

func _on_horker_end(isWin):
	if isWin : play("win")
	else :lose()
		
	pass # Replace with function body.
func lose():
	$"..".remove_life()
	if $"..".is_game_over(): 
		play("over")
	else: play("lose")
	
func _on_swift_end(isWin):
	if isWin :
		play("win")
		$"..".add_life()
	else: lose()
