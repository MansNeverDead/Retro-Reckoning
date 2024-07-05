extends Control

class_name  SaveGame


@export var saves_list : VBoxContainer
var saves : Array
var user_name : String = "player"
var level : int = 0
var selected_save : SaveContainer


func _ready():
	Main.save_game = self
	for save in saves_list.get_children():
		saves.append(save)
		save.connect("save_selected",SelectSave)
	LoadSaves()


#in this function we search for saves files and check ther information and display them
func LoadSaves():
	var dir = DirAccess.open("user://")
	dir.make_dir("saves")
	dir.change_dir("user://saves")
	
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name.contains(".reckoning"):
			LoadSave(file_name)
			file_name = dir.get_next()
	
	

#here we get save and add it to the saves array
func LoadSave(file_name:String):
	var file_path : String = "user://saves//" + file_name
	var save_file = FileAccess.open_compressed(file_path,FileAccess.READ,FileAccess.COMPRESSION_GZIP)
	
	while  save_file.get_position() < save_file.get_length():
		var line = save_file.get_line()
		var json = JSON.new()
		var result = json.parse(line)
		var save_game = json.get_data()
		var save = saves[save_game["id"]]
		save.save_game = save_game
		save.disabled = false
		save.path = file_path
		save.set_values(save_game)
		
		

#first click select save second load save
func SelectSave(save : SaveContainer):
	selected_save = save
	print(save.name)



func _on_savegame_pressed():
	if selected_save == null: return
	var id = saves.find(selected_save)
	var save_game = {
		"id":id,
		"inventory":"items_array", 
		"health": 100,
		"location":"house",
		"date": get_date(),
		"time": get_time()
	}
	selected_save.save_game = save_game
	selected_save.set_values(save_game)
	#selected_save.path = file_path
	#create new save file or open existing one
	var file_path : String = "user://saves//" + "save" + str(id) + ".reckoning"
	var save_file = FileAccess.open_compressed(file_path,FileAccess.WRITE,FileAccess.COMPRESSION_GZIP)
	#turning the save data dictionary into json string
	var json_main = JSON.stringify(save_game)
	
	#save the data in the form of json file
	save_file.store_line(json_main)

func _on_delete_pressed():
	if selected_save == null: return
	DirAccess.remove_absolute(selected_save.path)
	selected_save.clear()
	selected_save = null

func _on_visibility_changed():
	if visible:LoadSaves()

#get date
func get_date() -> String:
	var dater = Time.get_datetime_dict_from_system()
	var date = "%02d/%02d/%02d" % [dater.day, dater.month, dater.year]
	return date
#get time
func get_time() -> String:
	var timer = Time.get_time_dict_from_system()
	var time = "%02d:%02d:%02d" % [timer.hour, timer.minute, timer.second]
	return time

