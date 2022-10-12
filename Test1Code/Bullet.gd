extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const MOVE_SPEED = 200

onready var dir = 1
var movement := Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	movement = Vector2.ZERO
	
	movement.x += dir * MOVE_SPEED
	
	print(movement.x)
	
	movement = move_and_slide(movement, Vector2.UP)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
#	pass


func _on_Area2D_body_entered(body):
	get_parent().remove_child(self)
