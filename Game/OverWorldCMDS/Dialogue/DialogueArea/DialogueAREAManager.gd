extends Node

var load_dialogue

func load_which_dialogue(scene_location):
	var scene_to_load
	
	match scene_location:
		"Kitchen":
			scene_to_load = houseScene1
		
	if dialogue_to_load != null:
			DialogueManager.show_example_dialogue_balloon()
