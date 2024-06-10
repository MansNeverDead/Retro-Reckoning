class_name Player extends CharacterBody2D

@export var Inv: inventory
@onready var weapon = $weapon
@onready var animationPlayer = $AnimationPlayer
@onready var PlayerSprite = $PlayerSprite
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const RUN_SPEED = 400.0
const WALL_JUMP_PUSHBACK = 750
const WALL_SLIDE_GRAVITY = 350
var can_move = true
var gravity = 980
var wallSliding = false
var lastDirection

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	move()
	jump()
	
	wallslide(delta)
	if Input.is_action_pressed("Shoot"):
		if lastDirection == 'left':
			weapon.scale.x = -1
			animationPlayer.play("attackLeft")
			weapon.scale.x = 1
		elif lastDirection == 'right':
			
			animationPlayer.play("attackRight")
	move_and_slide()

func _ready():
	pass

func _on_spawn(position: Vector2, _direction: String):
	global_position = position

func move():
	var direction = Input.get_axis("left", "right")
	#moving and changing players sprite direction
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction == 1:
		PlayerSprite.flip_h = false
		lastDirection = "right"
	if direction == -1:
		PlayerSprite.flip_h = true
		lastDirection = "left"
	if can_move == false:
		velocity.x = 0
	
	#running
	if Input.is_action_pressed("sprint"):
		velocity.x = RUN_SPEED * direction

func jump():
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			#if is_on_floor():
				#.play("idle animation")
		if Input.is_action_pressed("left")  && is_on_wall():
			velocity.y = JUMP_VELOCITY
			velocity.x = WALL_JUMP_PUSHBACK
		if Input.is_action_pressed("right") && is_on_wall():
			velocity.y = JUMP_VELOCITY
			velocity.x = -WALL_JUMP_PUSHBACK

func wallslide(delta):
	if is_on_wall() && !is_on_floor():
		if Input.is_action_pressed("left") || Input.is_action_pressed("right"):
			wallSliding = true
		else:
			wallSliding = false
	else:
		wallSliding = false
	
	if wallSliding:
		velocity.y += (WALL_SLIDE_GRAVITY * delta)
		velocity.y = min(velocity.y, WALL_SLIDE_GRAVITY)
