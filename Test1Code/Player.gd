extends KinematicBody2D

onready var anim = $AnimationPlayer

const MOVE_SPEED = 100
const JUMP_FORCE = 200
const GRAVITY = 1000

var velocity := Vector2.ZERO

func _physics_process(delta: float) -> void:
	if(position.y > 100):
		get_tree().reload_current_scene()
	
	# reset horizontal velocity
	velocity.x = 0

	# set horizontal velocity
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		if Input.is_action_pressed("move_right"):
			velocity.x += MOVE_SPEED
			play_anim("Run")
		if Input.is_action_pressed("move_left"):
			velocity.x -= MOVE_SPEED
			play_anim("Run")
	else: 
		play_anim("Idle")
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y -= JUMP_FORCE

	# apply gravity
	# player always has downward velocity
	velocity.y += GRAVITY * delta
	# actually move the player
	velocity = move_and_slide(velocity, Vector2.UP)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func play_anim(animation):
	if(!anim.get_current_animation() == animation):
		anim.play(animation)
