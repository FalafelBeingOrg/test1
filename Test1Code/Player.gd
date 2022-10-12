extends KinematicBody2D

onready var anim = $AnimationPlayer
onready var area = $Area2D
onready var exit = get_node("/root/World/Exit")
onready var ladder = get_node("/root/World/Ladder")
onready var level_manager = get_node("/root/LevelManager")
onready var bullet := preload("res://Bullet.tscn")
onready var sprite = $Sprite

const MOVE_SPEED = 100
const JUMP_FORCE = 200
const CLIMB_FORCE = 40
const GRAVITY = 1000
const TIME_TO_SHOOT = 10

var time_since_shot = TIME_TO_SHOOT
var is_on_ladder = false
var is_on_door = false
var velocity := Vector2.ZERO
var is_facing_right = true

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		try_shoot()
	
	if Input.is_action_just_pressed("jump") and is_on_door:
		level_manager.next_level()
	if(position.y > 100):
		get_tree().reload_current_scene()
	
	# reset horizontal velocity
	velocity.x = 0
	# set horizontal velocity
	do_anim()
	
	do_movement()
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
	
	check_flip()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func play_anim(animation):
	if(!anim.get_current_animation() == animation):
		anim.play(animation)

func check_flip():
	if sprite.flip_h == is_facing_right:
		sprite.flip_h = !sprite.flip_h

func do_anim():
	if is_on_floor():
		if Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left"):
			play_anim("Run")
		else: 
			play_anim("Idle")
	elif velocity.y < 0:
		play_anim("Jump_Up")
	else:
		play_anim("Jump_Down")
		
func create_bullet():
	var bullet_instance = bullet.instance()
	get_node("/root/World").add_child(bullet_instance)
	bullet_instance.position = position
	if (is_facing_right):
		bullet_instance.dir = 1
	else:
		bullet_instance.dir = -1

func do_movement():
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
			if Input.is_action_pressed("move_right"):
				velocity.x += MOVE_SPEED
				is_facing_right = true
			if Input.is_action_pressed("move_left"):
				velocity.x -= MOVE_SPEED
				is_facing_right = false
	if is_on_floor() and Input.is_action_just_pressed("jump"):
			velocity.y -= JUMP_FORCE

func _on_Area2D_body_entered(body):
	if (body == ladder):
		is_on_ladder = true
	if (body == exit):
		is_on_door = true
	

func _on_Area2D_body_exited(body):
	if (body == ladder):
		is_on_ladder = false
	if (body == exit):
		is_on_door = false
		
func try_shoot():
	time_since_shot += 1
	if time_since_shot >= TIME_TO_SHOOT:
		time_since_shot = 0
		create_bullet()
