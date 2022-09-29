extends KinematicBody2D

const SPEED = 500

onready var parent = get_parent()
onready var velocity = parent.aim * SPEED
func _ready():
	print(parent)
	
func _process(delta):
	move_and_slide(velocity)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Area2D_body_entered(body):
	print ("bullet entered body: " + body.name)
	if body.name != "Player" and !body.name.trim_prefix("@").begins_with("Enemy") and !body.name.trim_prefix("@").begins_with("Bullet"):
		die()
	
func die():
	get_parent().remove_child(self)
