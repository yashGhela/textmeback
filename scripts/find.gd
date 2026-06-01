extends State

func enter():
	print("FOUND YOU BITCH!!!")
	get_tree().call_deferred("change_scene_to_file","res://game-elements/caught_screen.tscn")
