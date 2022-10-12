extends Node2D

const levels = [preload("res://LevelSelect.tscn"), preload("res://World.tscn")]
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func change_level(level):
	get_tree().change_scene_to(levels[level])
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
