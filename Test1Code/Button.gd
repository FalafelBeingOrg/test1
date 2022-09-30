extends Button

onready var Text = $"/root/Game/TextEdit"

var pos = 0
var is_flipped = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_parent().remove_child(self)
	
	if Input.is_action_just_pressed("move_left"):
		pos -= 1
		is_flipped = false
	elif Input.is_action_just_pressed("move_right"):
		pos += 1
		is_flipped = false
		
	if pos < 0:
		pos = Text.befores.size()-1
	if pos > Text.befores.size()-1:
		pos = 0
	print(Text.befores)
	
	if is_flipped:
		text = Text.afters[pos]
	else:
		text = Text.befores[pos]
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func _on_Button_pressed() -> void:
	is_flipped = !is_flipped

