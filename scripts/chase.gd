extends State

@export var boss:CharacterBody3D
@export var move_speed:=3.0

var player:CharacterBody3D



func enter():
	print("Enter chase")
	player =get_tree().get_first_node_in_group("Player")
	
	if player == null:
		push_error("No Player in group 'Player")
		return
	else:
		print("Player found")


func update_target_location(target_location):
	boss.nav_agent.set_target_location(target_location)


func physics_update(_delta:float):
	
	
	print("chasing")
	
	var current_location = boss.global_transform.origin
	var next_location = boss.nav_agent.get_next_location()
	var new_velocity = (next_location-current_location).normalized() * move_speed	
	boss.velocity= new_velocity
	if player == null:
		Transitioned.emit(self, "Scan")
		return
	var distance = boss.global_position.distance_to(player.global_position)
	
	if distance > 4.0:
		Transitioned.emit(self, "Scan")
		return
	
	if distance<1.0:
		Transitioned.emit(self,"Find")
		return
	
	var direction = (player.global_position - boss.global_position).normalized()
	direction.y = 0
	
	if direction.length() > 0.01:
		# Look at player's position
		boss.look_at(player.global_position, Vector3.UP)
		#boss.velocity = direction * move_speed
	else:
		boss.velocity = Vector3.ZERO
		
