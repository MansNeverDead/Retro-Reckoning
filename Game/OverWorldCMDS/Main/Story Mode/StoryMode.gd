extends Control

class_name StoryMode

@export var level1_part1_scene : PackedScene

func _ready():
	Main.story_mode = self

func _on_solo_pressed():
	var level1_part1 = level1_part1_scene.instantiate()
	Main.add_child(level1_part1)
	Main.hide_all()
	Main.ingame = true

func _on_duo_pressed():
	pass # Replace with function body.
