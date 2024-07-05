extends Control

class_name  MainMenu

func _ready():
	visible = true
	Main.main_menu = self

func _input(event):
	if Input.is_action_just_pressed("ui_cancel") && !Main.ingame:
			Main.hide_all()
			Main.main_menu.visible = true

func _on_new_game_pressed():
	Main.hide_all()
	Main.story_mode.visible = true
	
func _on_load_game_pressed():
	Main.hide_all()
	Main.load_game.visible = true


func _on_options_pressed():
	Main.hide_all()
	Main.options.visible = true


func _on_quit_game_pressed():
	get_tree().quit()
