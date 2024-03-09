extends CharacterBody2D

# the signal thing creates a signal, that's hwo you can creaate signals, will be useful later
signal health_depleted

var health = 100.0

# with this function you move the player
func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * 600
	move_and_slide()
	
	# here we set the dmg rate and with the overlappign mobs will allow us to see if there are mobs touching the playe
	const DAMAGE_RATE = 500.0
	var overlapping_mobs = %hurt_box.get_overlapping_bodies()
	
	#if there are overlapping mobs it will take HP and if get hit, the progress bar we have put an unique name to
	# will take dmg, and when that happens will change the value of the progress bar, to make it visible for the playe
	if overlapping_mobs.size() > 0:
		health -=DAMAGE_RATE * overlapping_mobs.size() * delta
		%ProgressBar.value = health
		
		# Here when the health reaches 0 it will emit the signal health depleted, which will be useful in the
		#game_test.gd script to show the death screen
		if health <= 0:
			health_depleted.emit()
			
