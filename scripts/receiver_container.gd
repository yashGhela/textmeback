extends PanelContainer

@onready var senderlabel: Label = $MarginContainer/senderlabel
@onready var label: Label = $MarginContainer/senderlabel


@onready var animation_player: AnimationPlayer = $AnimationPlayer

var receiverbox = load("res://game-elements/shaders/receivertres.tres") as StyleBox

var senderbox = load("res://game-elements/shaders/sendertres.tres") as StyleBox

var failed = load("res://game-elements/shaders/failed.tres") as StyleBox


func callNewMessage(text, type, delivered):
	print(text)
	print("Delivered status: ", delivered)
	label.text=text
	if type == 'r':
		if delivered==false:
			label.add_theme_stylebox_override('normal',failed)
			return
		label.add_theme_stylebox_override("normal", receiverbox)
	elif type=='s':
		if delivered==false:
			label.add_theme_stylebox_override('normal',failed)
			return
		label.add_theme_stylebox_override('normal',senderbox)
	
	
	#animation_player.play("popuptext")
