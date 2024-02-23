extends CanvasLayer

@onready var pause_menu = $"Pause Menu"
var paused = false

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()

func pauseMenu():
	if paused:
		Engine.time_scale = 1
		pause_menu.hide()
	else:
		pause_menu.show()
		Engine.time_scale = 0
	
	paused =! paused
