extends Area2D

# this is useful to destroy the bullet to avoid lag
var travelled_distance = 0

func _physics_process(delta):
	
	# the range is usefull to destroy the bullet when it travels as much as the range
	const SPEED = 1000
	const RANGE = 1200
	
	# i forgot what this did again but bassicaly when shot from the gun it makes sure that it is 
	#rotated correctly and than gets created
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta
	
	# here when the traveled distances ir more than the allowed range it gets destroyed
	travelled_distance += SPEED * delta 
	if travelled_distance > RANGE:
		queue_free()

# here when it hits a collision it gets destroyed, but if it hits a body with the function tkae dmg
# it takes dmg
func _on_body_entered(body):
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage()
