extends KinematicBody2D

const bullet := preload("res://Bullet.tscn")
onready var player = $"/root/World/Player"
var aim := Vector2()
var velocity := Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _process(delta):
	aim = position.direction_to(player.position)
	print(aim)
	velocity = aim * 100
	print(velocity)
	move_and_slide(velocity)


func create_bullet() -> void:
	var instance := bullet.instance()
	instance.connect("hit", self, "method")
	get_parent().add_child(instance)
	# etc
