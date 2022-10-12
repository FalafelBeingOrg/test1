extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var bullet := preload("res://RainDrop.tscn")


var j = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	if j == 10:
		j = 0
		spawn()
	j += 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func spawn():
	var bullet_instance := bullet.instance() as KinematicBody2D
	bullet_instance.position.y = -150
	bullet_instance.position.x = rand_range(-100,100)
	add_child(bullet_instance)
