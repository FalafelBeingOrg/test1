extends TextEdit

onready var line_edit = get_parent().get_node("LineEdit")
onready var Text = $"/root/Game/TextEdit"
var b = 0
var found = false
# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = ""

func _process(delta: float) -> void:
	print(Text.name)

	if Input.is_action_just_pressed("ui_cancel"):
		get_parent().remove_child(self)
	
	b = 0
	found = false
	text = ""
	for i in Text.befores:
		if line_edit.text == "":
			print("line edit ''")
		if i.findn(line_edit.text) != -1 or line_edit.text == "":
			text = text + "\n" + Text.befores[b] + "\n" + Text.afters[b]
			found = true
		b += 1
	if !found:
		text = "Not Found"
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
