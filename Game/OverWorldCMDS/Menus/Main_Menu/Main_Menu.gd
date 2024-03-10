extends Control



func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	move_to_front()


func _on_play_pressed():
	get_tree().change_scene_to_file("res://OverWorldCMDS/Menus/Story Mode/story_mode.tscn")

func _on_settings_pressed():
	get_tree().change_scene_to_file("res://OverWorldCMDS/Menus/Settings_Menu/Settings.tscn")

func _on_quit_pressed():
	get_tree().quit()
