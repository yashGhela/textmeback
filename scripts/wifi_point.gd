extends Node3D


@export var text_key=""
var active_area =false

@export var zonename:="None"


func _input(event):
	if active_area and event.is_action_pressed("interact"):
		print("Interacting with wifi point")
		
		Signalbus.emit_signal("display_texts", text_key)
		Signalbus.emit_signal("wififound",zonename)




func _on_interaction_zone_area_entered(area: Area3D) -> void:
	active_area=true # Replace with function body.


func _on_interaction_zone_area_exited(area: Area3D) -> void:
	active_area=false # Replace with function body.
