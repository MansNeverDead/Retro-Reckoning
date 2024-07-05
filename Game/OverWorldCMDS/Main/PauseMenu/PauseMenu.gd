extends Control

class_name PauseMenu

func _ready():
	Main.pause_menu = self


func _input(event):
	if Input.is_action_just_pressed("ui_cancel") && Main.ingame:
		if visible : 
			visible = false
		else :
			Main.hide_all()
			visible = true


func _on_resume_pressed():
	visible = false


func _on_save_game_pressed():
	Main.hide_all()
	Main.save_game.visible = true


func _on_options_pressed():
	Main.hide_all()
	Main.options.visible = true
