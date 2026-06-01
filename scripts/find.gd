extends State

func enter():
	print("FOUND YOU BITCH!!!")
	get_tree().change_scene_to_file("res://game-elements/caught_screen.tscn")
