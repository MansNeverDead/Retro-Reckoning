extends Node2D

var direction = Input.is_action_pressed("up") or Input.is_action_pressed("left") or Input.is_action_pressed("right")
@onready var weapon = $"."
@onready var animiationPlayer = $"."
func _physics_process(delta):
	pass



func rotateWeapon(direction):
	# Define the target position and rotation for the gun based on the direction
	var target_position = Vector2.ZERO
	var target_rotation = 0.0
	
	if Input.is_action_pressed("left"):
		target_position = Vector2(-10, 0)
		scale.x = -1  # Flip horizontally
	elif Input.is_action_pressed("up"):
		target_position = Vector2( 0, -40)
		target_rotation = -90.0
		scale.x = 1
	elif Input.is_action_pressed("right"):
		target_position = Vector2(10, 0)
		scale.x = 1  # Flip horizontally
	
	weapon.position = target_position
	weapon.rotation_degrees = target_rotation



func _on_body_entered(body):
	if body.has_method("takeDamage"):
		body.take_damage()
		queue_free()
		if body.had_method("knockback"):
			body.knockback()
	
