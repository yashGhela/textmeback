extends State

@export var boss:CharacterBody3D

@export var rotation_speed := 1.5  # radians per second
@export var rotation_limit := 45


var base_rotation_y := 0.0
var time := 0.0

func enter():
	print("scaning")
	var tween = create_tween()
	tween.set_loops()  # Infinite loop
	tween.tween_property(boss, "rotation_degrees:y", -45, 2.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(boss, "rotation_degrees:y", 45, 2.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	get_tree().create_timer(3.0).timeout.connect(func():
		if boss.pathFollow:
			boss.pathFollow.progress = 0
		
		Transitioned.emit(self,"FollowPath"))
