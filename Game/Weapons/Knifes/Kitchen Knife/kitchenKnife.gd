class_name Hitbox
extends Node2D

const attackDamage = 5
const knockback = 100
var direction = Input.is_action_pressed("up") or Input.is_action_pressed("left") or Input.is_action_pressed("right") 
@onready var weapon = $"."
@onready var animationPlayer = $AnimationPlayer;

func _physics_process(delta):
	rotateWeapon(direction)
	
	if Input.is_action_pressed("Shoot"):
		animationPlayer.play("attack")
	else:
		animationPlayer.play("RESET")





func rotateWeapon(_direction):
	# Define the target position and rotation for the weapon based on the direction
	var target_position = Vector2.ZERO
	var target_rotation = 0.0
	
	if Input.is_action_pressed("left"):
		target_position = Vector2(-30, 0)
		scale.x = -1  # Flip horizontally
	elif Input.is_action_pressed("up"):
		target_position = Vector2( 0, -40)
		target_rotation = -90.0
		scale.x = 1
	elif Input.is_action_pressed("right"):
		target_position = Vector2(30, 0)
		scale.x = 1  # Flip horizontally
	
	weapon.position = target_position
	weapon.rotation_degrees = target_rotation



func _on_area_2d_body_entered(body):
	if body.has_method("takeDamage"):
		var attack = Damage.new()
		attack.attackDamage = attackDamage
		attack.knockback = knockback
		attack.attackPosition = global_position
		body.takeDamage(Damage)
