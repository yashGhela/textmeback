extends Area3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var active_area = false
@export var is_interactable:=true
@export var Player:Node3D
var location

func _input(event):
	if active_area and event.is_action_pressed("interact") and is_interactable:
		print("Interacting")
		animation_player.play("shake")
		#Signalbus.emit_signal("shelfShaken", location) this will send the location to the boss ai
		


func _on_area_entered(area: Area3D) -> void:
	print(active_area)
	active_area=true # Replace with function body.


func _on_area_exited(area: Area3D) -> void:
	print(active_area)
	active_area=false # Replace with function body.
