extends State

@export var boss:CharacterBody3D
@onready var animation_player: AnimationPlayer = $"../../character/AnimationPlayer"

var is_moving_to_start = false

func enter():
	boss.is_pathing = false
	is_moving_to_start = true
	print("Returning to path starts")

func physics_update(_delta:float):
	if !is_moving_to_start:
		return
	
	# Get the first point on the path curve
	var start_point = boss.path.curve.get_point_position(0)
	var global_start_point = boss.path.global_transform * start_point
	
	print("return point: ", global_start_point)
	boss.nav_agent.target_position = global_start_point
	
	var dist_to_loc = boss.global_position.distance_to(global_start_point)
	
	# Check if we've reached the start point
	if dist_to_loc < 1.0:  # Increased threshold for better detection
		print("Reached path start")
		boss.velocity = Vector3.ZERO
		is_moving_to_start = false
		
		# Reset path follow progress
		if boss.pathFollow:
			boss.pathFollow.progress = 0
		
		# Transition back to FollowPath state
		Transitioned.emit(self, "FollowPath")
		return
	
	# Movement using navigation agent
	if boss.nav_agent.is_navigation_finished():
		# If navigation is finished but we're not at target, try setting target again
		boss.nav_agent.target_position = global_start_point
	else:
		var next_location = boss.nav_agent.get_next_path_position()
		var dir = boss.global_position.direction_to(next_location)
		var new_velocity = dir * 3.0
		boss.velocity = new_velocity
		
		# Look at the target position (not the start point, but the next navigation point)
		var look_target = Vector3(next_location.x, boss.global_position.y, next_location.z)
		if boss.global_position.distance_to(look_target) > 0.1:
			boss.look_at(look_target, Vector3.UP)
	
	# Play animation
	animation_player.play("Armature|mixamo_com_001")
