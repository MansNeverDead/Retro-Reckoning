extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var _isInRange = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


const DialogueSettings = preload("res://addons/dialogue_manager/settings.gd")
@onready var title: String = DialogueSettings.get_user_value("run_title")
@onready var resource: DialogueResource = load(DialogueSettings.get_user_value("run_resource_path"))



func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	

	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
	if GlobalVariables.isRunning != true:
		if _isInRange== true && Input.is_action_just_pressed("interact"):
			DialogueManager.show_example_dialogue_balloon(load("res://OverWorldCMDS/Dialogue/Main.dialogue"), "weep")
			return
		
		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY



func _on_detection_area_body_entered(body):
	if body.has_method("weep"):
		_isInRange = true
		print("entered body and seen function")
	print("entered body")


func _on_detection_area_body_exited(body):
	if body.has_method("weep"):
		_isInRange = true
		print("left body and seen function")
	print("has left body")


