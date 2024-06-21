extends Control

@onready var itemVisual: Sprite2D = $CenterContainer/Panel/itemDisplay
@onready var amountText: Label = $CenterContainer/Panel/Label

func update(slot: inventorySlot):
	if !slot.item:
		itemVisual.visible = false
		amountText.visible = false
	else:
		itemVisual.visible = true
		itemVisual.texture = slot.item.texture
		if slot.amount > 1:
			amountText.visible = true
		amountText.text = str(slot.amount)

