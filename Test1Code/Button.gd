extends Button

onready var Text = $"/root/Game/TextEdit"
onready var Panel2 = get_parent().get_node("Panel2")
onready var LabelText= get_node("Label")

var pos = 0
var is_flipped = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


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
	
	if Text.befores.size() > 0:
		if is_flipped:
			LabelText.text = Text.afters[pos]
			Panel2.visible = true
		else:
			LabelText.text = Text.befores[pos]
			Panel2.visible = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func _on_Button_pressed() -> void:
	is_flipped = !is_flipped

