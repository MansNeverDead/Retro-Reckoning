extends Node


func _input(event):
	print(event.as_text())

# The mouvement file starts from here and
func _process(delta):
	mouvement()

const speed = 200

func mouvement():
	var velocity = Vector2()  # NO MATTER WHAT, do not put anything in the vector

	# Check for key presses and update velocity accordingly
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1

func update_animation():
	var velocity = Vector2() 
	
	if velocity.x != 0 or velocity.y != 0:
		# If the sprite is moving, play the "walk" animation
		$AnimatedSprite.play("walk")
	else:
		# If the sprite is not moving, play the "idle" animation
		$AnimatedSprite.play("idle")

	# Normalize the velocity vector to ensure consistent speed in all directions
	velocity = velocity.normalized()

	# Move the AnimatedSprite using the velocity and speed
	$AnimatedSprite.position += velocity * speed * get_process_delta_time()
# ends here

