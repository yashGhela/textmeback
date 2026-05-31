extends State

@export var boss:CharacterBody3D

func physics_update(_delta:float):
	var location =boss.pathStart.global_position
	
	var disttoloc= boss.global_position.distance_to(location)
	
	if disttoloc<=0.5:
		boss.velocity= Vector3.ZERO
		if boss.pathFollow:
			boss.pathFollow.progress = 0
		
		Transitioned.emit(self,"FollowPath")
		return
		
	
	var dir = boss.global_position.direction_to(location)
		
	boss.velocity=dir*3.0
		
	var look_target=  Vector3(location.x, boss.global_position.y, location.z)
	if boss.global_position.distance_to(look_target)>0.1:
		boss.look_at(look_target,Vector3.UP)
	
