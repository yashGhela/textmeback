extends CharacterBody3D

@export var pathFollow:PathFollow3D
@export var path:Path3D
@export var distLoc=null
@onready var state_machine: Node = $StateMachine
@onready var investigate: Node = $StateMachine/Investigate
@export var pathStart:Node3D
@onready var chase: Node = $StateMachine/Chase
@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D
@export var caughtscreen:Control
@onready var freeze: Node = $StateMachine/Freeze

@onready var scan: Node = $StateMachine/Scan

var is_pathing=true

func update_target_location(target_location):
	nav_agent.target_position=target_location

func _ready() -> void:
	
	Signalbus.connect("freezeboss",Callable(self, "on_freeze_boss"))

func investigate_shelf(location):
	print(location)
	distLoc=location
	state_machine.current_state=investigate

func on_freeze_boss():
	state_machine.current_state = freeze

func _physics_process(delta: float) -> void:
	if !is_pathing:
		move_and_slide()
	


func _on_seekzone_area_entered(area: Area3D) -> void:
	is_pathing=false
	print(area)
	if area.is_in_group("Player"):
		state_machine.current_state=chase 



func _on_closezone_area_entered(area: Area3D) -> void:
	is_pathing=false
	if area.is_in_group("Player"):
		state_machine.current_state=chase 
