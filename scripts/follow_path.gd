extends State

@export var boss:CharacterBody3D

func physics_update(delta:float):
	var totalPathlength = boss.path.curve.get_baked_length()
	var direction =1.0
	if boss.pathFollow.progress>=totalPathlength:
		direction=-1.0
		boss.pathFollow.progress+=2.0*delta*direction
	else:
		boss.pathFollow.progress+=2.0*delta
