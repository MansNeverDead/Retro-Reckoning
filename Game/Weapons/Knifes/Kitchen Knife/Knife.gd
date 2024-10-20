extends Node2D

const attackDamage = 5
const knockback = 100
var right: bool
@onready var weapon = $"."
@onready var animationPlayer = $AnimationPlayer

func _physics_process(_delta):
	var target_position = Vector2.ZERO
	var direction = Input.get_axis("left", "right")
	if direction == 1:
		target_position = Vector2(200, 0)
		scale.x = 1
		right = true
	elif direction == -1:
		scale.x = -1
		right = false
	
	if Input.is_action_just_pressed("Attack") && !right:
		scale.x = 1
		animationPlayer.play("attackLeft")
	elif Input.is_action_just_pressed("Attack") && right:
		animationPlayer.play("attackRight")
	if !right:
		target_position = Vector2(20, 0)
	weapon.position = target_position

func _on_body_entered(body):
	if body.has_method("takeDamage"):
		var attack = Damage.new()
		attack.attack_damage = attackDamage
		attack.knockback = knockback
		attack.attack_position = global_position
		body.takeDamage(attack)
