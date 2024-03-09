extends Area2D

var doneShooting: bool = true

@onready var animationPlayer = $AnimationPlayer
@onready var gun = $"."




func _physics_process(_delta):
	if Input.is_action_just_pressed("Shoot"):
		print("Shoot has been initiated")
		shoot()
	# Handle input for movement
	
	move_and_rotate_gun(Input.is_action_pressed("up") ||Input.is_action_pressed("left") ||Input.is_action_pressed("right"))
	
func shoot():
	animationPlayer.play("Shoot")
	const BULLET = preload("res://Weapons/Guns/MAC-50/MAC-50 Bullet/MAC-50Bullet.tscn")
	var new_bullet = BULLET.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
	new_bullet.global_position = $"PointPivot/Mac-50Spritesheet/FirePoint".global_position
	new_bullet.global_rotation = $"PointPivot/Mac-50Spritesheet/FirePoint".global_rotation
	$"PointPivot/Mac-50Spritesheet/FirePoint".add_child(new_bullet)

func move_and_rotate_gun(_direction):
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
	
	gun.position = target_position
	gun.rotation_degrees = target_rotation

"""
Name: idk
desc Ion know either
"""
