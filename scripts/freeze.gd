extends State

@export var boss:CharacterBody3D

func physics_update(_delta:float):
	boss.velocity= Vector3.ZERO
