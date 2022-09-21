extends Node2D

onready var player = $"../Player"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.transform.x.distance_to(player.transform.x) < 0.1:
		self.transform.x = player.transform.x
	else:
		self.transform.x.move_toward(player.transform.x, delta * 500)

