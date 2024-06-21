extends Node2D

const attackDamage = 5
const knockback = 100
var lastLook
@onready var weapon = $"."
@onready var animationPlayer = $AnimationPlayer

func _physics_process(_delta):
	var target_position = Vector2.ZERO
	var is_left

	if Input.is_action_pressed("left"):
		scale.x = -1  # Flip horizontally.
		target_position = Vector2(-10, 0)
		is_left = true
	
	if Input.is_action_pressed("right"):
		target_position = Vector2(10, 0)
		scale.x = 1  # Flip horizontally
		is_left = false
	
	if Input.is_action_just_pressed("Shoot"):
		if is_left:
			animationPlayer.play("attackLeft")
		if !is_left:
			animationPlayer.play("attackRight")
	
	if is_left:
		target_position = Vector2(-20, 0)
	if !is_left:
		target_position = Vector2(20, 0)
	weapon.position = target_position

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
