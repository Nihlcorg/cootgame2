extends AnimationPlayer

func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.is_pressed():
			stop(true)
			$"../../RatSFX".play()
			$Rat.scale.y = .1
