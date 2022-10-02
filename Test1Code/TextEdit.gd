extends TextEdit

const operator = "->"

var card_scene = preload("res://Card.tscn")
var search_scene = preload("res://Search.tscn")
var lines = []
var befores = []
var afters = []
var result
var after
var before


func _ready():
	text = load_file()
	add_keyword_color(operator, Color(0.925781, 0.014465, 0.014465))
	
func _process(delta: float) -> void:
	if Input.is_action_pressed("ctrl"):
		print("ctrl pressed")
		if Input.is_action_just_pressed("save"):
			save(text)
		if Input.is_action_just_pressed("load"):
			text = load_file()
		if Input.is_action_just_pressed("card"):
			var card = card_scene.instance()
			add_child(card)
			save(text)
		if Input.is_action_just_pressed("search"):
			save(text)
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
	var card = card_scene.instance()
	add_child(card)
	save(text)




func _on_Button2_pressed() -> void:
	save(text)
	
	
func _on_Button3_pressed() -> void:
	text = load_file()
	
func save(content):
	var file = File.new()
	file.open("user://save.txt", File.WRITE)
	file.store_string(content)
	file.close()

func load_file():
	var file = File.new()
	file.open("user://save.txt", File.READ)
	var content = file.get_as_text()
	file.close()
	return content




func _on_Button4_pressed() -> void:
	save(text)
	var search = search_scene.instance()
	add_child(search)
