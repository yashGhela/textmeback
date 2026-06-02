extends State

@export var boss:CharacterBody3D
var direction =1.0

@onready var animation_player: AnimationPlayer = $"../../character/AnimationPlayer"


func enter():
	print("Following path")


func update(delta:float):
	
	if boss.pathFollow.progress_ratio>=0.99:
		direction=-1.0
	elif boss.pathFollow.progress_ratio<=0.01: 
		direction=1.0
	
	boss.pathFollow.progress+=2.0*delta*direction
	animation_player.play("Armature|mixamo_com_001")
	
