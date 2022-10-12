extends KinematicBody2D

onready var sprite = $Sprite

const MOVE_SPEED = 10
const GRAVITY = 100
var velocity := Vector2.ZERO
var is_facing_right = false

func _physics_process(delta: float) -> void:
	velocity.x = 0
	
	do_movement()
	check_flip()

func check_flip():
	if is_on_wall():
		is_facing_right = !is_facing_right
		sprite.flip_h = !sprite.flip_h


func do_movement():
	if is_facing_right:
		velocity.x += MOVE_SPEED
	else:
		velocity.x -= MOVE_SPEED
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, Vector2.UP)
