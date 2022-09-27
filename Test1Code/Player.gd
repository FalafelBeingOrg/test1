extends KinematicBody2D

const MOVE_SPEED = 600
const MAX_SPEED = 1000
const JUMP_FORCE = 600
const GRAVITY = 75
const JUMP_BOOST = GRAVITY * 0.75
const MAX_FALL_SPEED = 500
const DASH_LENGTH = 10
const DASH_COOLDOWN = 50
const DASH_SPEED = 700
const CHAIN_PULL = 100
const FRICTION_AIR = 0.95		# The friction while airborne
const FRICTION_GROUND = 0.85

onready var anim_player = $AnimationPlayer
onready var Idle = $Idle
onready var Jump_Down = $Jump_Down
onready var Jump_Up = $Jump_Up
onready var Run = $Run
onready var Dash = $Dash
onready var Slash = $Slash

var facing_right = false
var time_since_grounded = 0
var time_since_dash = DASH_COOLDOWN
var canjump = true

var velocity = Vector2(0,0)		# The velocity of the player (kept over time)
var chain_velocity := Vector2(0,0)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			# We clicked the mouse -> shoot()
			$Chain.shoot(event.position - get_viewport().size * 0.5)
		else:
			# We released the mouse -> release()
			$Chain.release()

func _physics_process(delta):
	var walk = (Input.get_action_strength("move_right") - Input.get_action_strength("move_left")) * MOVE_SPEED

	move_and_slide(velocity, Vector2(0, -1))
	
	var grounded = is_on_floor()
	
	if is_on_ceiling():
		velocity.y = 0
	
	
	velocity.y += GRAVITY
	
	if $Chain.hooked:
		# `to_local($Chain.tip).normalized()` is the direction that the chain is pulling
		chain_velocity = to_local($Chain.tip).normalized() * CHAIN_PULL
		if chain_velocity.y > 0:
			# Pulling down isn't as strong
			chain_velocity.y *= 0.55
		else:
			# Pulling up is stronger
			chain_velocity.y *= 1.65
		if sign(chain_velocity.x) != sign(walk):
			# if we are trying to walk in a different
			# direction than the chain is pulling
			# reduce its pull
			chain_velocity.x *= 0.7
	else:
		# Not hooked -> no chain velocity
		chain_velocity = Vector2(0,0)
	velocity += chain_velocity

	velocity.x += walk		# apply the walking
	move_and_slide(velocity, Vector2.UP)	# Actually apply all the forces
	velocity.x -= walk		# take away the walk speed again
	# ^ This is done so we don't build up walk speed over time

	# Manage friction and refresh jump and stuff
	velocity.y = clamp(velocity.y, -MAX_SPEED, MAX_SPEED)	# Make sure we are in our limits
	velocity.x = clamp(velocity.x, -MAX_SPEED, MAX_SPEED)

	if grounded:
		velocity.x *= FRICTION_GROUND	# Apply friction only on x (we are not moving on y anyway)
		if velocity.y >= 5:		# Keep the y-velocity small such that
			velocity.y = 5		# gravity doesn't make this number huge
	elif is_on_ceiling() and velocity.y <= -5:	# Same on ceilings
		velocity.y = -5
		
	if is_on_wall():
		velocity.x = 0
	
	if Input.is_action_just_pressed("jump") and canjump:
		if grounded:
			velocity.y = -JUMP_FORCE
		else:
			time_since_grounded = 0
			canjump = false
			velocity.y = -JUMP_FORCE
	if !grounded and time_since_grounded < 30 and Input.is_action_pressed("jump"):
		velocity.y += -JUMP_BOOST
	if grounded and velocity.y >=5:
		velocity.y = 5
	if velocity.y > MAX_FALL_SPEED:
		velocity.y = MAX_FALL_SPEED
		
	if time_since_dash >= DASH_LENGTH:
		if facing_right and velocity.x > 0:
			flip()
		if !facing_right and velocity.x < 0:
			flip()
		
		if grounded:
			canjump = true
			time_since_grounded = 0
			if walk == 0:
				play_anim("Idle")
			else:
				play_anim("Run")
		else:
			time_since_grounded += 1
			if velocity.y > 0:
				play_anim("Jump_Up")
			else:
				play_anim("Jump_Down")
	else:
		velocity.x = (walk / MOVE_SPEED) * DASH_SPEED
		play_anim("Dash")
	
	if time_since_dash >= DASH_COOLDOWN and Input.is_action_just_pressed("dash"):
		time_since_dash = 0
		if walk > 0:
			velocity.x += DASH_SPEED
		elif walk < 0:
			velocity.x -= DASH_SPEED
		elif Input.is_action_pressed("jump"):
			velocity.y -= DASH_SPEED
		else:
			velocity.y += DASH_SPEED
	
	time_since_dash += 1
	
	if position.y > 1000:
		die()
		
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
	
func die():
	get_tree().change_scene("res://World.tscn")
	
func hide_all():
	Idle.hide()
	Jump_Down.hide()
	Jump_Up.hide()
	Run.hide()
	Dash.hide()
	Slash.hide()
