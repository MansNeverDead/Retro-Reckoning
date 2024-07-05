extends Node


@export var worlds : PackedScene

var isRunning: bool = true

var isInRange: bool = false

var inventoryIndex: int = 0

var ingame = false

var main_menu : MainMenu
var pause_menu : PauseMenu
var save_game : SaveGame
var load_game : LoadGame
var options : Options
var story_mode : StoryMode


func hide_all():
	main_menu.visible = false
	pause_menu.visible = false
	save_game.visible = false
	load_game.visible = false
	options.visible = false
	story_mode.visible = false
