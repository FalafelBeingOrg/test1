extends KinematicBody2D

const MOVE_SPEED = 500
const JUMP_FORCE = 1000
const GRAVITY = 50
const MAX_FALL_SPEED = 1000

onready var anim_player = $AnimationPlayer
onready var Idle = $Idle
onready var Jump_Down = $Jump_Down
onready var Jump_Up = $Jump_Up
onready var Run = $Run

var y_velo = 0
var facing_right = false

func _physics_process(delta):
	var move_dir = 0
	if Input.is_action_pressed("move_right"):
		move_dir += 1
	if Input.is_action_pressed("move_left"):
		move_dir -= 1
	move_and_slide(Vector2(move_dir * MOVE_SPEED, y_velo), Vector2(0, -1))
	
	var grounded = is_on_floor()
	
	if is_on_ceiling():
		y_velo = 0
	
	y_velo += GRAVITY
	if grounded and Input.is_action_just_pressed("jump"):
		y_velo = -JUMP_FORCE
	if grounded and y_velo >=5:
		y_velo = 5
	if y_velo > MAX_FALL_SPEED:
		y_velo = MAX_FALL_SPEED
		
	if facing_right and move_dir < 0:
		flip()
	if !facing_right and move_dir > 0:
		flip()
		
	if grounded:
		if move_dir == 0:
			play_anim("Idle")
		else:
			play_anim("Run")
	elif y_velo > 0:
		play_anim("Jump_Up")
	else:
		play_anim("Jump_Down")
		
	
		
func flip():
	facing_right = !facing_right
	Idle.flip_h = !Idle.flip_h
	Jump_Down.flip_h = !Jump_Down.flip_h
	Jump_Up.flip_h = !Jump_Up.flip_h
	Run.flip_h = !Run.flip_h
	
func play_anim(anim_name):
	if anim_player.is_playing() and anim_player.current_animation == anim_name:
		return
	anim_player.play(anim_name)
	hide_all()
	get_node(anim_name).show()
	
func hide_all():
	Idle.hide()
	Jump_Down.hide()
	Jump_Up.hide()
	Run.hide()
