extends CharacterBody3D

@export var pathFollow:PathFollow3D
@export var path:Path3D
@export var distLoc=null
@onready var state_machine: Node = $StateMachine
@onready var investigate: Node = $StateMachine/Investigate
@export var pathStart:Node3D
@onready var chase: Node = $StateMachine/Chase

@onready var scan: Node = $StateMachine/Scan


func _ready() -> void:
	Signalbus.connect("shakeShelf",Callable(self,"on_shake_shelf"))

func on_shake_shelf(location):
	print(location)
	distLoc=location
	state_machine.current_state=investigate

func _physics_process(delta: float) -> void:
	move_and_slide()
	


func _on_seekzone_area_entered(area: Area3D) -> void:
	print(area)
	if area.is_in_group("Player"):
		state_machine.current_state=chase 



func _on_closezone_area_entered(area: Area3D) -> void:
	if area.is_in_group("Player"):
		state_machine.current_state=chase 
