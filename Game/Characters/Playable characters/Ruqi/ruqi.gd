extends CharacterBody2D
class_name Player 
@export var Inv: inventory
@onready var animationPlayer = $AnimationPlayer
@onready var playerInv: inventory = load("res://OverWorldCMDS/Inventory/playerInventory.tres")
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const RUN_SPEED = 400.0
const WALL_JUMP_PUSHBACK = 750
const WALL_SLIDE_GRAVITY = 350
var can_move = true
var gravity = 980
var wallSliding = false
var previousItem: Area2D = null


func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	move()
	jump()
	wallslide(delta)
	move_and_slide()
	if Input.is_action_just_pressed("Inventory"):
		inventoryUiDone()
	

func _on_spawn(_position: Vector2, _direction: String):
	global_position = _position

func move():
	var direction = Input.get_axis("left", "right")
	#moving and changing players sprite direction
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if direction == 1:
		animationPlayer.play("moveRight")
	elif direction == -1:
		animationPlayer.play("moveLeft")
	else:
		animationPlayer.play("standing")
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
			animationPlayer.play("standing")
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

func equipWeapon():
	if GlobalVariables.inventoryIndex == 0:
		equipItem()
	elif GlobalVariables.inventoryIndex == 1:
		equipItem()
	elif GlobalVariables.inventoryIndex == 2:
		equipItem()
	else:
		return

func equipItem():
	deletePreviousItem()
	var item_slot = playerInv.slots[GlobalVariables.inventoryIndex]
	var item = item_slot.item 
	var itemPath = item.Path
	var instance = load(itemPath)
	var cannonFodder = instance.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
	$"weaponSpawn".add_child(cannonFodder)
	previousItem = cannonFodder

func deletePreviousItem():
	if previousItem != null:
		previousItem.queue_free()
		previousItem = null

func inventoryUiDone():
	equipItem()
