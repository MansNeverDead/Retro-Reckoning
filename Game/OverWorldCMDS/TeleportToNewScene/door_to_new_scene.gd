extends Area2D

class_name Door

@export var destination_level_tag: String
@export var destination_door_tag: String
@export var spawn_direction = "up"

@onready var spawn = $Marker2D

func _on_body_entered(body):
	if body is Player:
		DoorManager.go_to_level(destination_level_tag, destination_door_tag)
