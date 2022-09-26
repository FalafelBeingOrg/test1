extends Node2D

onready var player = $Player
onready var grapple = $grapple
onready var ray = $Player/RayCast2D

func _process(delta):
	grapple.global_position = player.global_position
	ray.look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("grapple"):
		if ray.is_colliding():
			var thingtostick = ray.get_collider()
			var distancelength = ray.get_collision_point().distance_to(player.global_position)
			
			grapple.length = distancelength
			grapple.global_rotation_degrees = ray.global_rotation_degrees-90
			
			grapple.node_b = thingtostick.get_path()
	
	pass
