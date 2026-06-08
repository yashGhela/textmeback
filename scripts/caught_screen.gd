extends Control


@export var file:String='zone_1'



func _on_play_button_pressed() -> void:
	match file:
		"zone_1":
			get_tree().change_scene_to_file("res://levels/zone_1.tscn")
		"zone_2":
			get_tree().change_scene_to_file("res://levels/zone_2.tscn")
		"zone_3":
			get_tree().change_scene_to_file("res://levels/zone_3.tscn")
		"zone_4":
			get_tree().change_scene_to_file("res://levels/zone_4.tscn")
