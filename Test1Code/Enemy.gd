extends KinematicBody2D

const bullet = preload("res://Bullet.tscn")
onready var player = $"/root/World/Player"
var aim := Vector2()
var i = 0

func _ready():
	pass
	
func _process(delta):
	aim = position.direction_to(player.position)
	if i == 100:
		print("instatniate")
		i = 0
		var instance = bullet.instance()
		add_child(instance)
	i+=1


func create_bullet():
	var instance = bullet.instance()
	add_child(instance)
