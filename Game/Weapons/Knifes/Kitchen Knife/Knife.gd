extends Node2D

const attackDamage = 5
const knockback = 100

@onready var weapon = $"."
@onready var animationPlayer = $AnimationPlayer

func _physics_process(delta):
	var target_position = Vector2.ZERO
	var target_rotation = 0.0
	var is_left = false

	if Input.is_action_pressed("left"):
		scale.x = -1  # Flip horizontally.
		target_position = Vector2(-10, 0)
		is_left = true
	elif Input.is_action_pressed("right"):
		target_position = Vector2(10, 0)
		scale.x = 1  # Flip horizontally
		is_left = false
	
	if Input.is_action_just_pressed("Shoot"):
		if is_left:
			animationPlayer.play("attackLeft")
		else:
			animationPlayer.play("attackRight")

	weapon.position = target_position
	weapon.rotation_degrees = target_rotation

func _on_body_entered(body):
	if body.has_method("takeDamage"):
		var attack = Damage.new()
		attack.attack_damage = attackDamage
		attack.knockback = knockback
		attack.attack_position = global_position
		body.takeDamage(attack)

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "attackLeft" or anim_name == "attackRight":
		animationPlayer.play("RESET")
