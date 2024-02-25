extends CharacterBody2D

const jumpPower = -2000.0
const SPEED = 300.0

const friction = 70

const JUMP_VELOCITY = -400.0
const wall_jump_pushback: int = 400
const wall_slide_gravity = 20
var is_wall_sliding = false
var _isInRange = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 150


const DialogueSettings = preload("res://addons/dialogue_manager/settings.gd")
@onready var title: String = DialogueSettings.get_user_value("run_title")
@onready var resource: DialogueResource = load(DialogueSettings.get_user_value("run_resource_path"))



func _physics_process(delta):
	
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		add_friction()
	move_and_slide()
	
	if GlobalVariables.isRunning != true:
		if _isInRange == true && Input.is_action_just_pressed("interact"):
			DialogueManager.show_example_dialogue_balloon(load("res://OverWorldCMDS/Dialogue/Main.dialogue"), "weep")
			return
		
		# Handle jump.
		jump()
		wallSlide(delta)
		
		


func add_friction():
	velocity = velocity.move_toward(Vector2.ZERO, friction)

func _on_detection_area_body_entered(body):
	if body.has_method("weep"):
		_isInRange = true
		print("entered body and seen function")
	print("entered body")


func _on_detection_area_body_exited(body):
	if body.has_method("weep"):
		_isInRange = true
		print("left body and seen function weep")
	print("has left body")

func jump():
	velocity.y += gravity
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jumpPower
		
		if is_on_wall() and Input.is_action_pressed("left"):
			gravity = 75
			velocity.y = jumpPower
			velocity.x = wall_jump_pushback
		else:
			gravity = 150
		
		if is_on_wall() and Input.is_action_pressed("right"):
			gravity = 75
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
		
