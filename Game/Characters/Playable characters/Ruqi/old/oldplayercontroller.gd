extends CharacterBody2D

const jumpPower = -2000.0
const SPEED = 300.0

const friction = 70

const JUMP_VELOCITY = -400.0
const wall_jump_pushback: int = 200
const wall_slide_gravity = 155
var is_wall_sliding = false
var _isInRange = false
var gravity = 150

var inventory: Array = []

const DialogueSettings = preload("res://addons/dialogue_manager/settings.gd")
@onready var title: String = DialogueSettings.get_user_value("run_title")
@onready var resource: DialogueResource = load(DialogueSettings.get_user_value("run_resource_path"))

var standingPre = preload("res://Characters/Playable characters/Ruqi/standing.tres")
var crouching = preload("res://Characters/Playable characters/Ruqi/crouching.tres")



func _physics_process(delta):
	
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		add_friction()
	move_and_slide()
	running()
	
	jump()
	
	wallSlide(delta)

func add_friction():
	velocity = velocity.move_toward(Vector2.ZERO, friction)

func jump():
	velocity.y += gravity
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jumpPower - 10
		
		if is_on_wall() and Input.is_action_pressed("left"):
			gravity = 115
			velocity.y = jumpPower
			velocity.x = wall_jump_pushback
		else:
			gravity = 150
		
		if is_on_wall() and Input.is_action_pressed("right"):
			gravity = 115
			velocity.y = jumpPower
			velocity.x = -wall_jump_pushback
		else:
			gravity = 150

func wallSlide(delta):
	if is_on_wall() and !is_on_floor():
		if Input.is_action_pressed("left") || Input.is_action_pressed("right"):
			is_wall_sliding = true
		else:
			is_wall_sliding = false
	else:
		is_wall_sliding = false
		
	
	if is_wall_sliding:
		velocity.y += (wall_slide_gravity * delta)
		velocity.y = min(velocity.y, wall_slide_gravity)

func running():
	var direction = Input.get_axis("left", "right")
	if Input.is_action_pressed("sprint"):
		if Input.is_action_pressed("jump") == false:
			if direction:
				velocity.x = direction * SPEED / 2.5
				move_and_slide()
			else:
				add_friction()
			move_and_slide()
