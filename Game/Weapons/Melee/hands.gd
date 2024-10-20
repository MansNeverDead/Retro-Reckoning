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
	elif direction == -1:
		right = false
	
	if Input.is_action_just_pressed("Attack") && right:
		animation.play("attackRight")
	elif Input.is_action_just_pressed("Attack") && !right:
		animation.play("attackLeft")

func mouvement():
	var direction = Input.get_axis("left", "right")
