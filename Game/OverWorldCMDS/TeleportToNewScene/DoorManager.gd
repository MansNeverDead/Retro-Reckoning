extends Node

const houseScene1 = preload("res://World scenes/World 1 scenes/Level 1/level_1_solo.tscn")
const level1Scene2TEST = preload("res://dontWorryAboutThis/node_2d.tscn")

var spawn_door_tag

func go_to_level(level_tag, destination_tag):
	var scene_to_load
	
	match level_tag:
		"House":
			scene_to_load = houseScene1
		"Lvl1Scene2":
			scene_to_load = level1Scene2TEST
		
	if scene_to_load != null:
			spawn_door_tag = destination_tag
			get_tree().change_scene_to_packed(scene_to_load)

