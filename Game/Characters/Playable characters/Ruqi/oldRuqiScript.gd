extends CharacterBody2D

class_name Player

@onready var AnimPlayer = $AnimationPlayer
@onready var PlayerSprite = $PlayerSprite

@export var SPEED = 300.0
@export var JUMP_VELOCITY = -400.0
@export var RUN_SPEED = 400.0
@export var WALL_JUMP_PUSHBACK = 155

var can_move = true
var can_jump = true
var is_wall_sliding = false


@export var WALL_JUMP_GRAVITY = 200
var gravity = 980


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		can_jump = false
	if is_on_floor():
		can_jump = true
	if is_on_floor() and velocity == Vector2(0,0):
		pass
			#AnimPlayer.play(play idle animation)
			
	move()
	jump()
	wallSlide(delta)
	move_and_slide()

func move():
	
	var direction = Input.get_axis("left", "right")

	#moving and changing players sprite direction
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction == 1:
		PlayerSprite.flip_h = false
	if direction == -1:
		PlayerSprite.flip_h = true
		
	if can_move == false:
		velocity.x = 0
		
	#running
	if Input.is_action_pressed("sprint"):
		velocity.x = RUN_SPEED * direction

func jump():
	if Input.is_action_just_pressed("jump") and can_move and can_jump:
		velocity.y = JUMP_VELOCITY
		#if is_on_floor():
			#AnimPlayer.play("idle animation")
	if can_move == false:
		velocity.y = 0
		
		if is_on_wall() and Input.is_action_pressed("left"):
			gravity = 115
			velocity.y = JUMP_VELOCITY
			velocity.x = WALL_JUMP_PUSHBACK
		else:
			gravity = 980
		
		if is_on_wall() and Input.is_action_pressed("right"):
			gravity = 115
			velocity.y = JUMP_VELOCITY
			velocity.x = -WALL_JUMP_PUSHBACK
		else:
			gravity = 980

func wallSlide(delta):
	if is_on_wall() and !is_on_floor():
		if Input.is_action_pressed("left") || Input.is_action_pressed("right"):
			is_wall_sliding = true
		else:
			is_wall_sliding = false
	else:
		is_wall_sliding = false
		
	if is_wall_sliding:
		velocity.y += (WALL_JUMP_GRAVITY * delta)
		velocity.y = min(velocity.y, WALL_JUMP_GRAVITY)
