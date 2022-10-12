extends KinematicBody2D

const SPEED = 250

onready var level_handler = get_node("/root/LevelHandler")
onready var area = $Area2D

var movement := Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	move()
	
func move():
	movement = Vector2.ZERO
	
	if Input.is_action_pressed("ui_down"):
		movement.y += SPEED
	if Input.is_action_pressed("ui_up"):
		movement.y -= SPEED
	if Input.is_action_pressed("ui_right"):
		movement.x += SPEED
	if Input.is_action_pressed("ui_left"):
		movement.x -= SPEED
	
	move_and_slide(movement, Vector2.UP)
	
func die():
	LevelHandler.change_level(0)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Area2D_body_entered(body: Node) -> void:
	print("a")
	if body.get_parent().name == "RainSpawner":
		die()
