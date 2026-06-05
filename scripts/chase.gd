extends State

@export var boss:CharacterBody3D
@export var move_speed:=3.0

var player:CharacterBody3D
@onready var animation_player: AnimationPlayer = $"../../character/AnimationPlayer"
@onready var character: Node3D = $"../../character"



func enter():
	print("Enter chase")
	player =get_tree().get_first_node_in_group("Player")
	
	if player == null:
		push_error("No Player in group 'Player")
		return
	else:
		print("Player found")




func physics_update(_delta:float):
	
	print("chasing")
	
	var current_location = boss.global_transform.origin
	var next_location = boss.nav_agent.get_next_path_position()
	var new_velocity = (next_location-current_location).normalized() * move_speed	
	boss.velocity= new_velocity.move_toward(new_velocity,.25)
	
	var distance = boss.global_position.distance_to(player.global_position)
	
	if distance > 7.0:
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
		
		#if character:
			#var target_angle = atan2(direction.x, direction.z)
			#character.rotation.y = lerp_angle(character.rotation.y, target_angle, 8.0 * _delta)
		animation_player.play("Armature|mixamo_com_001")
		#boss.velocity = direction * move_speed
	else:
		boss.velocity = Vector3.ZERO
		
