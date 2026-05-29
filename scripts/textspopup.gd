extends CanvasLayer

@export_file("*json") var scene_text_file: String

var scene_text: Dictionary = {}
var selected_text: Array = []
@onready var textspopup: CanvasLayer = $"."
@onready var textmsgportal: TextureRect = $textmsgportal
var in_progress: bool = false
@onready var senderlabel: Label = $textmsgportal/senderlabel
@onready var receiverlabel: Label = $textmsgportal/receiverlabel


#we are testing changes here
func _ready():
	textmsgportal.visible=false
	scene_text= load_scene_text()
	Signalbus.connect("display_texts",Callable(self, "on_display_texts"))


func load_scene_text():
	if FileAccess.file_exists(scene_text_file):
		var file = FileAccess.open(scene_text_file, FileAccess.READ)
		var test_json_conv = JSON.new()
		test_json_conv.parse(file.get_as_text())
		return test_json_conv.get_data()
		

func show_text():
	var current_text = selected_text.pop_front()
	match current_text.sender:
		"P":
			senderlabel.text= current_text.content
		"G":
			receiverlabel.text= current_text.content

func next_line():
	if selected_text.size() > 0:
		show_text()
	else:
		finish()

func finish():
	Signalbus.emit_signal("textingover")
	senderlabel.text = ""
	textmsgportal.visible = false
	in_progress = false
	
	
	
	
	
		
func on_display_texts(text_key):
	if in_progress:
		next_line()
	else:
		print("This is the text key: ", text_key)
		
		
		
		textmsgportal.visible = true
		in_progress = true
		selected_text = scene_text[text_key].duplicate()
		show_text()
