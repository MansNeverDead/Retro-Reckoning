extends Node2D

@onready var pause_menu = $"CanvasLayer2/Pause Menu"
var paused = false

func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		pauseMenu()

# here when everything is ready, it will spawn mobs, you can only do this with the ready()  
# bc else it will for fucks sake
# talk to ALO to know why
func _ready():
	spawn_mob()
	spawn_mob()
	spawn_mob()
	spawn_mob()
	spawn_mob()

# here it creates more instances of the Mob scene
func spawn_mob():
	var new_mob = preload("res://Tests/Chracyter test/Enemy/mobby.tscn").instantiate()
	
	# here it goes to pathfollow2d node to create a random position there to spawn the mob
	%PathFollow2D.progress_ratio = randf()
	
	#when that happens it is gonna preload the mob scene on the global position of path node
	new_mob.global_position = %PathFollow2D.global_position
	
	# here it creates a new node child of the mob scene, spawning a mob
	add_child(new_mob)


# here it spawns mobs periodically after the times runs out
func _on_timer_timeout():
	spawn_mob()
	spawn_mob()
	spawn_mob()
	spawn_mob()
	spawn_mob()

# here it takes THE SIGNAL FROM PLAYER.GD SCRIPT that i said would be useful, it'll take that signal
# to show the GameOver canvas and also pause the game
func _on_player_health_depleted():
	%GameOver.visible = true
	get_tree().paused = true
	
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	
	paused =! paused
