extends Node3D

@onready var player:CharacterBody3D = get_tree().get_first_node_in_group("Player")


func _ready() -> void:
	player = get_tree().get_first_node_in_group("Player")

func _physics_process(delta: float) -> void:
	if !player:
		return
	get_tree().call_group("Boss", "update_target_location",player.global_transform.origin)
