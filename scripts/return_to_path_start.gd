extends State

@export var boss:CharacterBody3D
@onready var animation_player: AnimationPlayer = $"../../character/AnimationPlayer"

func enter():
	print("Returning to path startsw")

func physics_update(_delta:float):
	var location =boss.pathStart.global_position
	boss.nav_agent.target_position = location
	
	
	var disttoloc= boss.global_position.distance_to(location)
	
	if boss.nav_agent.is_navigation_finished():
		boss.velocity= Vector3.ZERO
		if boss.pathFollow:
			boss.pathFollow.progress = 0
		
		Transitioned.emit(self,"FollowPath")
		return
	
	var current_location = boss.global_transform.origin
	var next_location = boss.nav_agent.get_next_path_position()
	var dir = boss.global_position.direction_to(location)
	var new_velocity = (next_location-current_location).normalized() * 3.0	
	boss.velocity= new_velocity.move_toward(new_velocity,.25)
	
		
	var look_target=  Vector3(location.x, boss.global_position.y, location.z)
	if boss.global_position.distance_to(look_target)>0.1:
		boss.look_at(look_target,Vector3.UP)
	
	animation_player.play("Armature|mixamo_com_001")
	
