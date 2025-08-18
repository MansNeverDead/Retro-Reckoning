extends Resource

class_name inventory
@export var slots: Array[inventorySlot]

func insert(item: inventoryItem):
	var itemSlots = slots.filter(func(slot): return slot.item == item)
	if !itemSlots.is_empty():
		# If the item already exists in inventory, increase its amount
		itemSlots[0].amount += 1
	else:
		# Check for an empty slot to place the new item
		var emptySlots = slots.filter(func(slot): return slot.item == null)
		if !emptySlots.is_empty():
			# Place the item in the first available empty slot
			emptySlots[0].item = item
			emptySlots[0].amount = 1
		else:
			# If no empty slots are available, replace the item in the first slot
			slots[0].item = item
			slots[0].amount = 1
