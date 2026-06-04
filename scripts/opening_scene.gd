extends Control

var text_key="OS"


func _ready() -> void:
	Signalbus.emit_signal("display_texts", text_key)



func _input(event):
	if event.is_action_pressed("interact"):
		print("Interacting with opening point")
		
		Signalbus.emit_signal("display_texts", text_key)
		
