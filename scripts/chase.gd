extends State

@export var boss:CharacterBody3D
var player:CharacterBody3D

func enter():
	print("Enter chase")
	player =get_tree().get_first_node_in_group("Player")


func physics_update(_delta:float):
	pass
