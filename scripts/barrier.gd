extends Area3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var active_area = false
@export var is_interactable:=true
@export var Player:Node3D
var location = self.global_position

func _input(event):
	if active_area and event.is_action_pressed("interact") and is_interactable:
		print("Interacting")
		animation_player.play("shake")
		Signalbus.emit_signal("shakeShelf",location)


func _on_area_entered(area: Area3D) -> void:
	
	active_area=true 
	print(active_area)


func _on_area_exited(area: Area3D) -> void:
	
	active_area=false 
	print(active_area)
