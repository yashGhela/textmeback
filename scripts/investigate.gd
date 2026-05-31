extends State

@export var boss:CharacterBody3D
var speed = 5.0

func enter():
	print("Entering Investigation mode")

func physics_update(_delta:float):
	var location =boss.distLoc
	
	var disttoloc= boss.global_position.distance_to(location)
	
	if disttoloc<=4.0:
		boss.velocity=Vector3.ZERO
		Transitioned.emit(self,"Scan")
		return
	
	var dir = boss.global_position.direction_to(location)
	
	boss.velocity=dir*speed
	
	var look_target=  Vector3(location.x, boss.global_position.y, location.z)
	if boss.global_position.distance_to(look_target)>0.1:
		boss.look_at(look_target,Vector3.UP)
		
	
	
