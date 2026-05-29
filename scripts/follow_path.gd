extends State

@export var boss:CharacterBody3D

func physics_update(delta:float):
	boss.pathFollow.progress+=2.0*delta
