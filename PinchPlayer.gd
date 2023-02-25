extends AnimationPlayer

var lost = false
var anim
var lossTimes = [1.45, 1.9]

func lose():
	lost = true

func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton and !lost:
		if event.button_index == BUTTON_LEFT and event.is_pressed():
			anim = current_animation
			if lossTimes.has(current_animation_position) : return
			$"../../HitSFX".play()
			play(anim, 0, -2, false)
			queue(anim)

func _on_PinchPlayer_animation_finished(_anim_name):
	lost = true
	pass # Replace with function body.
