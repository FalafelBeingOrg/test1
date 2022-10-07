extends TextEdit

const operator = ">"


onready var Dialog = $"/root/Game/FileDialog"
onready var DialogSV = $"/root/Game/FileDialogsv"
var card_scene = preload("res://Card.tscn")
var search_scene = preload("res://Search.tscn")
var lines = []
var befores = []
var afters = []
var result
var after
var before
var load_path ="user://save.txt"
var SVContent = ""
var svfile_path ="user://save.save"
var isfocused = true

signal refresh

func _ready():
	ldNoPopup()
	
func _process(delta: float) -> void:
	if !isfocused:
		grab_focus()
		isfocused = true
	if Input.is_action_pressed("ui_cancel"):
		grab_focus()
	if Input.is_action_pressed("ctrl"):
		print("ctrl pressed")
		if Input.is_action_just_pressed("save"):
			save(text)
		if Input.is_action_just_pressed("load"):
			load_file()
		if Input.is_action_just_pressed("card"):
			svNoPopup(text)
			var card = card_scene.instance()
			add_child(card)
		if Input.is_action_just_pressed("search"):
			svNoPopup(text)
			var search = search_scene.instance()
			add_child(search)
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://Game.tscn")
	lines.clear()
	afters.clear()
	befores.clear()
	
	for line in text.split("\n"):
		lines.append(line)
	
	for i in lines:
		if i.find(operator) != -1:
			result = i.find(operator)
			after = i.substr(result+operator.length(), i.length()).trim_prefix(" ").trim_suffix(" ")
			before = i.substr(0, result).trim_prefix(" ").trim_suffix(" ")
			afters.append(after)
			befores.append(before)
	
			
func _on_Button1_pressed():
	svNoPopup(text)
	var card = card_scene.instance()
	add_child(card)




func _on_Button2_pressed() -> void:
	save(text)
	
	
func _on_Button3_pressed() -> void:
	load_file()
	
func save(content):
	DialogSV.popup()
	SVContent = content
	

func load_file():
	Dialog.popup()
	emit_signal("refresh")
	
func svNoPopup(content):
	var svfile = File.new()
	svfile.open(svfile_path, File.READ)
	load_path = svfile.get_as_text()
	svfile.close()
	if load_path != "":
		var file = File.new()
		file.open(load_path, File.WRITE)
		file.store_string(content)
		file.close()

func ldNoPopup():
	var svfile = File.new()
	svfile.open(svfile_path, File.READ)
	load_path = svfile.get_as_text()
	svfile.close()
	if load_path != "":
		var file = File.new()
		file.open(load_path, File.READ)
		text = file.get_as_text()
		file.close()


func _on_Button4_pressed() -> void:
	svNoPopup(text)
	var search = search_scene.instance()
	add_child(search)


func _on_FileDialog_file_selected(path):
	var file = File.new()
	file.open(path, File.READ)
	text = file.get_as_text()
	file.close()
	isfocused = false

func _on_FileDialogsv_file_selected(path):
	var svfile = File.new()
	svfile.open(svfile_path, File.WRITE)
	svfile.store_string(path)
	svfile.close()
	var file = File.new()
	file.open(path, File.WRITE)
	file.store_string(SVContent)
	file.close()
	isfocused = false
