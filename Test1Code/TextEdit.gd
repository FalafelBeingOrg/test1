extends TextEdit

func _ready():
	add_keyword_color("hello", Color(0.925781, 0.014465, 0.014465))
	add_color_region('"','"', Color(0.014465, 0.925781, 0.818986))
	add_color_region('//','', Color(0.522949, 0.53125, 0.530277), true)
	
	var animals = ['dog', 'cat', 'bean']
	
	for i in animals:
		add_keyword_color(i, Color(0.914063, 0.003571, 0.003571))
