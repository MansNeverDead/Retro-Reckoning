extends Button

class_name  SaveContainer

signal save_selected(SaveContainer)

var save_game : Dictionary 
var id : int
var path : String
var texture : Texture

@onready var screanshot : TextureRect = $data/screanshot
@onready var location : Label = $data/location
@onready var date : Label = $data/date
@onready var time : Label = $data/time

func set_values(save):
	#screanshot.texture = get_viewport().get_texture()
	location.text = save["location"]
	date.text = save["date"]
	time.text = save["time"]

func clear():
	location.text = "empty"
	date.text = "date"
	time.text = "time"

func _on_pressed():
	emit_signal("save_selected",self)
