extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var bread = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	$"../AnimationPlayer".play("wiggle")
	pass # Replace with function body.

func _physics_process(delta):
	if Input.is_action_pressed("ui_down"):
		move_and_slide(Vector2(0, bread))
	if Input.is_action_pressed("ui_up"):
		move_and_slide(Vector2(0, -bread))
	if Input.is_action_pressed("ui_left"):
		move_and_slide(Vector2(-bread,0))
	if Input.is_action_pressed("ui_right"):
		move_and_slide(Vector2(bread,0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body is RigidBody2D:
		body.gravity_scale = 1
		pass
	pass # Replace with function body.
