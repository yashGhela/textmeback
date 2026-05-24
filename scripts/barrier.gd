extends MeshInstance3D


@onready var animation_player: AnimationPlayer = $AnimationPlayer
var active_area = false


func _input(event):
	if active_area and event.is_action_pressed("interact"):
		print("Interacting")
		#Signalbus.emit_signal("display_dialog", dialog_key)
		#Signalbus.emit_signal("talking")
		#
