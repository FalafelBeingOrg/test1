extends KinematicBody2D

onready var anim = $AnimationPlayer
onready var area = $Area2D
onready var ladder = get_node("/root/World/Ladder")

const MOVE_SPEED = 100
const JUMP_FORCE = 200
const CLIMB_FORCE = 40
const GRAVITY = 1000

var is_on_ladder = false
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
	if(!is_on_ladder):
		velocity.y += GRAVITY * delta
	else:
		velocity.y = 0
		if Input.is_action_pressed("jump"):
			velocity.y -= CLIMB_FORCE
		if Input.is_action_pressed("ui_down"):
			velocity.y += CLIMB_FORCE
	# actually move the player
	velocity = move_and_slide(velocity, Vector2.UP)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func play_anim(animation):
	if(!anim.get_current_animation() == animation):
		anim.play(animation)




func _on_Area2D_body_entered(body):
	if (body == ladder):
		is_on_ladder = true

func _on_Area2D_body_exited(body):
	if (body == ladder):
		is_on_ladder = false
