extends Area2D

@onready var animation = $AnimationPlayer
var right: bool
var attackDamage: int = 5
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	var direction = Input.get_axis("left", "right")
	if direction == 1:
		right = true
		print(" is true")
	elif direction == -1:
		right = false
		print("is false")
	
	if Input.is_action_just_pressed("Attack") && right:
		animation.play("attackRight")
		scale.x = 1
		print("right played")
	elif Input.is_action_just_pressed("Attack") && !right:
		print("left played")
		scale.x = -1
		animation.play("attackLeft")

func mouvement():
	var direction = Input.get_axis("left", "right")
