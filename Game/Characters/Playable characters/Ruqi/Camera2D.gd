extends Camera2D

var target_distance = 0
var center_position = position

func _process(delta):
	var targer_position = center_position * target_distance
	
	position = targer_position


func _input(event):
	if event is InputEventAction:
		target_distance = center_position.direction_to(get_global_transform()) / 2
