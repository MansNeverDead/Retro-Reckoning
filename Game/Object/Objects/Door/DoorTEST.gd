extends CharacterBody2D

@onready var doorCollision = $CollisionShape2D
@onready var interactionArea = $InteractionArea
var ionKnow = false

func openDoor():
	
	if ionKnow && Input.is_action_just_pressed("interact"):
			var newDoorCollision = preload("res://Object/Objects/Door/doorCollisionShapeClose.tscn").instantiate()
			
			$".".add_child(newDoorCollision)
			ionKnow = false
	
	
	if ionKnow == false && Input.is_action_just_pressed("interact"):
			doorCollision.queue_free()
			print("it works")
			ionKnow = true


func _ready():
	interactionArea.interact = Callable(self, "openDoor")
