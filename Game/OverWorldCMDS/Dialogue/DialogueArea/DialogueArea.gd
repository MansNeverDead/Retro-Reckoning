extends Area2D

class_name DialogueManagerArea

@export var scene_location: String

func _on_body_entered(body):
	if body is Player:
		DoorManager.load_which_dialogue(scene_location)
