extends Control

@onready var playerInventory: inventory = preload("res://OverWorldCMDS/Inventory/playerInventory.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var color = $NinePatchRect/GridContainer/inventoryUiSlot/ColorRect
@onready var color2 = $NinePatchRect/GridContainer/inventoryUiSlot2/ColorRect
@onready var color3 = $NinePatchRect/GridContainer/inventoryUiSlot3/ColorRect
@onready var time = $Timer
var indexSlot = -1
var isOpen = false
signal done

func _process(_delta):
	if Input.is_action_just_pressed("Inventory"):
		changeSlot()
		if !isOpen:
			updateSlots()
			changeIndex()
			open()
			time.start()
		else:
			_on_timer_timeout()

func _ready():
	close()
	updateSlots()
	set_process(true)

func close():
	visible = false
	isOpen = false

func open():
	self.visible = true
	isOpen = true

func updateSlots():
	for i in range(min(playerInventory.slots.size(), slots.size())):
		slots[i].update(playerInventory.slots[i])

func changeSlot():
	if indexSlot == 0:
		color.color = Color(1, 1, 1)
		color3.color = Color(0.557, 0.729, 0.235)
		Main.inventoryIndex = 0
	elif indexSlot == 1:
		color2.color = Color(1, 1, 1)
		color.color = Color(0.557, 0.729, 0.235)
		Main.inventoryIndex = 1
	elif indexSlot == 2:
		color3.color = Color(1, 1, 1)
		color2.color = Color(0.557, 0.729, 0.235)
		Main.inventoryIndex = 2
	done.emit()
	return color && color2 && color3

func changeIndex():
	indexSlot += 1
	if indexSlot == 3:
		indexSlot = 0
	changeSlot()
	return indexSlot

func _on_timer_timeout():
	close()
	time.stop()
