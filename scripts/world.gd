extends Node3D

@onready var player:CharacterBody3D = get_tree().get_first_node_in_group("Player")


func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")
	Signalbus.connect("shakeShelf",Callable(self,"on_shake_shelf"))

func on_shake_shelf(location):
	print(location)
	var bosstoinvestigate:CharacterBody3D = get_closest_enemy(location)
	bosstoinvestigate.investigate_shelf(location)
	
func _physics_process(delta: float) -> void:
	if !player:
		return
	get_tree().call_group("Boss", "update_target_location",player.global_transform.origin)

func get_closest_enemy(location:Vector3) -> CharacterBody3D:
	var closest: CharacterBody3D = null
	var closest_distance := INF
	
	for node in get_tree().get_nodes_in_group("Boss"):
		if not node is CharacterBody3D:
			continue
		var boss = node as CharacterBody3D
		if boss == null:
			continue
		
		var distance := location.distance_squared_to(boss.global_position)
		
		if distance < closest_distance:
			closest_distance = distance
			closest = boss
	
	return closest

	
