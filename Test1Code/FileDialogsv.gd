extends FileDialog


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
func _draw() -> void:
	set_current_dir("user://")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_TextEdit_refresh() -> void:
	show_hidden_files = false
	show_hidden_files = true
