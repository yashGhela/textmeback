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
@onready var ray_cast_3d: RayCast3D = $RayCast3D

@export var raycast_distance: float = 5.0
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
	

func is_barrier_in_front(target_position: Vector3) -> bool:
	# Calculate direction to the target
	var direction = (target_position - global_transform.origin).normalized()
	
	# Set up the raycast
	ray_cast_3d.target_position = direction * raycast_distance
	ray_cast_3d.force_raycast_update()
	
	# Check if the raycast hit a barrier
	if ray_cast_3d.is_colliding():
		var collider = ray_cast_3d.get_collider()
		if collider.is_in_group("Barrier"):
			return true
	
	return false

func _on_seekzone_area_entered(area: Area3D) -> void:
	is_pathing=false
	print(area)
	if area.is_in_group("Player"):
		if !is_barrier_in_front(area.global_transform.origin):
			state_machine.current_state=chase 



func _on_closezone_area_entered(area: Area3D) -> void:
	is_pathing=false
	if area.is_in_group("Player"):
		if !is_barrier_in_front(area.global_transform.origin):
			state_machine.current_state=chase 
