extends TextureProgress

signal out

func _on_Timer_timeout():
	value -= .1
	if value == 0 : emit_signal("out")
