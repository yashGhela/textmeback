extends State

@export var boss:CharacterBody3D
@export var move_speed:=3.0

var player:CharacterBody3D

func enter():
	print("Enter chase")
	player =get_tree().get_first_node_in_group("Player")


func physics_update(_delta:float):
	var direction = player.global_position - boss.global_position
	
	direction.y=0
	
	if direction.length() > 0.01:
		boss.look_at(boss.global_position - direction, Vector3.UP)
	
	if direction.length()<10:
		if direction.length()<3:
			Transitioned.emit(self,"Find")
			
		else:
			boss.velocity = direction.normalized() * move_speed
	
	else:
		boss.velocity = Vector3.ZERO
		
	if direction.length()>10:
		Transitioned.emit(self,"Scan")
		
