extends CanvasLayer

@export_file("*json") var scene_text_file: String

var scene_text: Dictionary = {}
var selected_text: Array = []
@onready var textspopup: CanvasLayer = $"."
@onready var textmsgportal: ColorRect = $textmsgportal
var in_progress: bool = false
const textscene = preload("res://game-elements/textcontainer.tscn")
@onready var message_container: VBoxContainer = $textmsgportal/MarginContainer/message_container

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
	var bubble = textscene.instantiate()
	
	# Create a row for this message
	var row = HBoxContainer.new()
	row.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	
	match current_text.sender:
		"P":  # sender – bubble on right
			var spacer = Control.new()
			spacer.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			row.add_child(spacer)
			row.add_child(bubble)
			
		"G":  # receiver – bubble on left
			row.add_child(bubble)
			var spacer = Control.new()
			spacer.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			row.add_child(spacer)
			
	
	message_container.add_child(row) 
	match current_text.sender:
		"P":
			bubble.callNewMessage(current_text.content, 's')
		"G":
			bubble.callNewMessage(current_text.content, 'r')
	 # message_container is your VBoxContainer	
func next_line():
	if selected_text.size() > 0:
		show_text()
	else:
		finish()

func finish():
	Signalbus.emit_signal("textingover")
	
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
