extends KinematicBody2D

const MOVE_SPEED = 500
const JUMP_FORCE = 1000
const GRAVITY = 75
const JUMP_BOOST = GRAVITY * 0.75
const MAX_FALL_SPEED = 1000
const DASH_LENGTH = 10
const DASH_COOLDOWN = 50
const DASH_SPEED = 2000

onready var anim_player = $AnimationPlayer
onready var Idle = $Idle
onready var Jump_Down = $Jump_Down
onready var Jump_Up = $Jump_Up
onready var Run = $Run
onready var Dash = $Dash
onready var Slash = $Slash

var x_velo = 0
var y_velo = 0
var facing_right = false
var time_since_grounded = 0
var time_since_dash = DASH_COOLDOWN
var canjump = true

func _physics_process(delta):
	var move_dir = 0
	if Input.is_action_pressed("move_right"):
		move_dir += 1
	if Input.is_action_pressed("move_left"):
		move_dir -= 1
	move_and_slide(Vector2(x_velo, y_velo), Vector2(0, -1))
	
	var grounded = is_on_floor()
	
	if is_on_ceiling():
		y_velo = 0
	
	
	y_velo += GRAVITY
	if Input.is_action_just_pressed("jump") and canjump:
		if grounded:
			y_velo = -JUMP_FORCE
		else:
			time_since_grounded = 0
			canjump = false
			y_velo = -JUMP_FORCE
	if !grounded and time_since_grounded < 30 and Input.is_action_pressed("jump"):
		y_velo += -JUMP_BOOST
	if grounded and y_velo >=5:
		y_velo = 5
	if y_velo > MAX_FALL_SPEED:
		y_velo = MAX_FALL_SPEED
		
	if time_since_dash >= DASH_LENGTH:
		if facing_right and move_dir > 0:
			flip()
		if !facing_right and move_dir < 0:
			flip()
		
		if grounded:
			canjump = true
			time_since_grounded = 0
			if move_dir == 0:
				play_anim("Idle")
			else:
				play_anim("Run")
		else:
			time_since_grounded += 1
			if y_velo > 0:
				play_anim("Jump_Up")
			else:
				play_anim("Jump_Down")
		x_velo = move_dir * MOVE_SPEED
	else:
		x_velo = move_dir * DASH_SPEED
		play_anim("Dash")
	
	if time_since_dash >= DASH_COOLDOWN and Input.is_action_just_pressed("dash"):
		time_since_dash = 0
		if move_dir > 0:
			x_velo += DASH_SPEED
		elif move_dir < 0:
			x_velo -= DASH_SPEED
		elif Input.is_action_pressed("jump"):
			y_velo -= DASH_SPEED*0.5
		else:
			y_velo += DASH_SPEED*2
	
	time_since_dash += 1
		
func flip():
	facing_right = !facing_right
	Idle.flip_h = !Idle.flip_h
	Jump_Down.flip_h = !Jump_Down.flip_h
	Jump_Up.flip_h = !Jump_Up.flip_h
	Run.flip_h = !Run.flip_h
	Dash.flip_h = !Dash.flip_h
	Slash.flip_h = !Slash.flip_h
	
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
	Dash.hide()
	Slash.hide()
