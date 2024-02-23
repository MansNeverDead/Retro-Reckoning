extends Node

@onready var text_box_scene = preload("res://OverWorldCMDS/Dialogue/text_box.tscn")


signal dialogue_finished()
var dialogue_lines: Array[String] = []
var current_line_index = 0

var text_box
var text_box_position: Vector2

var is_dialogue_active = false
var can_advance_line = false

func start_dialog(position: Vector2, lines: Array[String]):
	if is_dialogue_active:
		return
	
	dialogue_lines = lines
	text_box_position = position
	_show_text_box()
	
	is_dialogue_active = true

func _show_text_box():
	text_box = text_box_scene.instantiate()
	text_box.finished_displaying.connect(_on_text_box_finished_displaying)
	get_tree().root.add_child(text_box)
	text_box.global_position = text_box_position
	text_box.display_text(dialogue_lines[current_line_index])
	can_advance_line = false
	

func _on_text_box_finished_displaying():
	can_advance_line = true
	dialogue_finished.emit()


func _unhandled_input(event):
	
	if (
		event.is_action_pressed("advance_dialogue") &&
		is_dialogue_active &&
		can_advance_line 
	):
		text_box.queue_free()
		
		current_line_index = 1
		if current_line_index >= dialogue_lines.size():
			is_dialogue_active = false
			current_line_index = 0
			dialogue_finished.emit()
			return
		dialogue_finished.emit()
		_show_text_box()
