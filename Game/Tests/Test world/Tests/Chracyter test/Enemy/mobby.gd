extends CharacterBody2D

# it's health
var health = 4

# when ready gets the player root
@onready var player = get_node("/root/Game_test/Player")

# here it looks for the player root and than slides over there
func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * 500.0
	move_and_slide()

# here it takes damage you'll see how in the bullet script
func take_damage():
	health -= 1
	
	# when reaches 0 gets destroyed
	if health == 0:
		queue_free()
