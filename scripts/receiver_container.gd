extends PanelContainer
@onready var senderlabel: Label = $MarginContainer/senderlabel

@export var text:String = ""

func callNewMessage():
	senderlabel.text=text
