extends AnimatedSprite2D

const speed = 200

func _process(delta):
	mouvement()

func mouvement():
	var velocity = Vector2()  # Initialize a Vector2 to store movement direction

	# Check for key presses and update velocity accordingly
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1

	# Normalize the velocity vector to ensure consistent speed in all directions
	velocity = velocity.normalized()

	# Move the AnimatedSprite using the velocity and speed
	position += velocity * speed * get_process_delta_time()

