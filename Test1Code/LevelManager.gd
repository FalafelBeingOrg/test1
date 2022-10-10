extends Node2D

var current_level = 0
var levels = [preload("res://World.tscn"), preload("res://World2.tscn")]
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func next_level():
	current_level += 1
	if current_level > levels.size()-1:
		current_level = 0
	get_tree().change_scene_to(levels[current_level])
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
