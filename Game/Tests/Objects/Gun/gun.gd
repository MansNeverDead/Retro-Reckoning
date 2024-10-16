extends Area2D



# here it checks if it senses if there is anything with a area2d and collisionshape node
# and creates a vector to see how many enemies there are in range
func _physics_process(delta):
	var enemies_in_range = get_overlapping_bodies()
	
	if enemies_in_range.size() > 0:
		var target = enemies_in_range.front()
		look_at(target.global_position)
		
	if Input.is_action_pressed("Shoot"):
		shoot()


# this creates an instance of the bullet scene and than makes sure that is spawns on the right place on the shooting
# point and than also makes sure that it stays connected on the player
# and than creates an instance of the pullet as a child of the gun
func shoot():
	# const BULLET = preload("res://Tests/Objects/Gun/Bullet/bullet.tscn")
	"""var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %shooting_point.global_position
	new_bullet.global_rotation = %shooting_point.global_rotation
	%shooting_point.add_child(new_bullet)"""
	
