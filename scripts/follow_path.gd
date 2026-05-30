extends State

@export var boss:CharacterBody3D
var direction =1.0


func update(delta:float):
	#var totalPathlength = boss.path.curve.get_baked_length()
	#print(totalPathlength)
	#print(boss.pathFollow.progress_ratio)
	#
	if boss.pathFollow.progress_ratio>=0.99:
		direction=-1.0
	elif boss.pathFollow.progress_ratio<=0.01: 
		direction=1.0
	
	boss.pathFollow.progress+=2.0*delta*direction
	
	
