extends CanvasLayer

@export_file("*json") var scene_text_file: String

var scene_text: Dictionary = {}
var selected_text: Array = []
@onready var textspopup: CanvasLayer = $"."
@onready var textmsgportal: ColorRect = $textmsgportal
@onready var scroll_container: ScrollContainer = $textmsgportal/MarginContainer/ScrollContainer
var in_progress: bool = false
const textscene = preload("res://game-elements/textcontainer.tscn")
@onready var message_container: VBoxContainer = $textmsgportal/MarginContainer/ScrollContainer/message_container
var pending_transition: String = ""
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
			bubble.callNewMessage(current_text.content, 's', current_text.delivered)
		"G":
			bubble.callNewMessage(current_text.content, 'r', current_text.delivered)
	
	if current_text.has("transition") and current_text.transition:
		pending_transition = current_text.transition
	 # message_container is your VBoxContainer	
	
	scroll_container.get_v_scroll_bar().value = scroll_container.get_v_scroll_bar().max_value
func next_line():
	if selected_text.size() > 0:
		show_text()
	

	else:
		finish()

func finish():
	Signalbus.emit_signal("textingover")
	for child in message_container.get_children():
		child.queue_free()

	textmsgportal.visible = false
	in_progress = false
	
	if pending_transition:
			match pending_transition:
				"zone_1":
					get_tree().change_scene_to_file("res://levels/zone_1.tscn")
				"zone_2":
					get_tree().change_scene_to_file("res://levels/zone_2.tscn")
				"zone_3":
					get_tree().change_scene_to_file("res://levels/zone_3.tscn")
				"zone_4":
					get_tree().change_scene_to_file("res://levels/zone_4.tscn")
				
	
	
	
	
	
		
func on_display_texts(text_key):
	if in_progress:
		next_line()
	else:
		print("This is the text key: ", text_key)
		
		for child in message_container.get_children():
			child.queue_free()

		
		
		textmsgportal.visible = true
		in_progress = true
		selected_text = scene_text[text_key].duplicate()
		show_text()
		
		
