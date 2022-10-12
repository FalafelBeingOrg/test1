extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const KILL_ZONE = 3000
const MOVE_SPEED = 200

onready var dir = 1
var movement := Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	if position.x > KILL_ZONE or position.x < -KILL_ZONE or position.y > KILL_ZONE or position.y < -KILL_ZONE:
		die()
	
	movement = Vector2.ZERO
	
	movement.x += dir * MOVE_SPEED
	
	movement = move_and_slide(movement, Vector2.UP)

func die():
	get_parent().remove_child(self)

func _on_Area2D_body_entered(body):
	get_parent().remove_child(self)
