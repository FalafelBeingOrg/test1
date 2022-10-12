extends KinematicBody2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"var movement := Vector2.ZERO
const SPEED = 50

var movement := Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	move()
	
func move():
	movement = Vector2.ZERO
	
	movement.y += SPEED
	
	move_and_slide(movement, Vector2.UP)
	
	if position.y > 500:
		die()
		
func die():
	get_parent().remove_child(self)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
