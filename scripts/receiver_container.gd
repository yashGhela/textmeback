extends PanelContainer

@onready var senderlabel: Label = $MarginContainer/senderlabel
@onready var label: Label = $MarginContainer/senderlabel


@onready var animation_player: AnimationPlayer = $AnimationPlayer

var receiverbox = load("res://game-elements/shaders/receivertres.tres") as StyleBox

var senderbox = load("res://game-elements/shaders/sendertres.tres") as StyleBox



func callNewMessage(text, type):
	print(text)
	
	label.text=text
	if type == 'r':
		label.add_theme_stylebox_override("reciever", receiverbox)
	elif type=='s':
		label.add_theme_stylebox_override('sender',senderbox)
	#animation_player.play("popuptext")
