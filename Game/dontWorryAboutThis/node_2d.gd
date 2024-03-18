extends Node2D

func _ready():
	if DoorManager.spawn_door_tag != null:
		on_level_spawn(DoorManager.spawn_door_tag)
	

func on_level_spawn(destination_tag: String):
	var door_path = "Doors/Door_" + destination_tag
	var door = get_node(door_path) as Door
