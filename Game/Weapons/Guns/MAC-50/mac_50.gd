extends Area2D

var doneShooting: bool = true

@onready var animationPlayer = $AnimationPlayer
@onready var gun = $"."
var direction = Input.is_action_pressed("up") or Input.is_action_pressed("left") or Input.is_action_pressed("right")

func _physics_process(_delta):
	if Input.is_action_just_pressed("Shoot"):
		shoot()
	# Handle input for movement
	rotateGun(direction)
	
func shoot():
	animationPlayer.play("Shoot")
	const BULLET = preload("res://Weapons/Guns/MAC-50/MAC-50 Bullet/MAC-50Bullet.tscn")
	var new_bullet = BULLET.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
	new_bullet.global_position = $"Mac-50Spritesheet/FirePoint".global_position
	new_bullet.global_rotation = $"Mac-50Spritesheet/FirePoint".global_rotation
	$"Mac-50Spritesheet/FirePoint".add_child(new_bullet)

func rotateGun(_direction):
	# Define the target position and rotation for the gun based on the direction
	var target_position = Vector2.ZERO
	var target_rotation = 0.0
	
	if Input.is_action_pressed("left"):
		target_position = Vector2(-5, 0)
		scale.x = -1  # Flip horizontally
	elif Input.is_action_pressed("up"):
		target_position = Vector2( 0, -50)
		target_rotation = -90.0
		scale.x = 1
	elif Input.is_action_pressed("right"):
		target_position = Vector2(5, 0)
		scale.x = 1  # Flip horizontally
	
	gun.position = target_position
	gun.rotation_degrees = target_rotation
