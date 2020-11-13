extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var TreeItemClass = preload("res://Tree.tscn")
const SlotClass = preload("res://Slot.gd")
onready var inventory_slots = $GridContainer
var last_slot_clicked
onready var Water = get_tree().get_root().find_node("water",true,false)
#var tree_type = null

signal air_tree_pressed
signal earth_tree_pressed
signal fire_tree_pressed
signal magma_tree_pressed
signal snoop_tree_pressed
signal water_tree_pressed
signal cotton_candy_tree_pressed
signal lightning_tree_pressed
signal bunny_tree_pressed
signal sand_tree_pressed
signal bubble_tree_pressed
signal tree_tree_pressed
signal laven_tree_pressed
signal rain_tree_pressed
signal marble_tree_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	#$ColorRect.color = Color(0,.960784,1,1)
	$TextureRect.set_size(Vector2(400,250))
	$TextureRect.set_position(Vector2(1100,710))
	$GridContainer.set_position(Vector2(1250,760))
	$GridContainer.columns = 6
	$GridContainer.set("custom_constants/vseparation",6)
	$GridContainer.set("custom_constants/hseparation",6) 
	Water.connect("add_to_inventory",self, "_add_to_inventory")
	#Water.connect("remove_from_inventory",self,"_remove_from_inventory")

	for inv_slot in inventory_slots.get_children():
		inv_slot.color = Color(.478431,.505882,.501961,1)
		inv_slot.connect("gui_input",self,"slot_gui_input",[inv_slot])

func slot_gui_input(event: InputEvent, slot: SlotClass):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT && event.pressed:
			#if !slot.inventory_item:
				#slot._add_inventory_item()
			
			#else:
			for inv_slot in inventory_slots.get_children():
				inv_slot.color = Color(.478431,.505882,.501961,1)
			slot.color = Color(0,1,0,1)
			
			if slot.tree_appearance == "air_sapling" && slot.inventory_item:
				emit_signal("air_tree_pressed")
				#slot._remove_inventory_item()
			elif slot.tree_appearance == "earth_sapling" && slot.inventory_item:
				emit_signal("earth_tree_pressed")
				#slot._remove_inventory_item()
			elif slot.tree_appearance == "fire_sapling"&& slot.inventory_item:
				emit_signal("fire_tree_pressed")
				#slot._remove_inventory_item()
			elif slot.tree_appearance == "magma_sapling"&& slot.inventory_item:
				emit_signal("magma_tree_pressed")
				#slot._remove_inventory_item()
			elif slot.tree_appearance == "snoop_sapling"&& slot.inventory_item:
				emit_signal("snoop_tree_pressed")
				#slot._remove_inventory_item()
			elif slot.tree_appearance == "water_sapling"&& slot.inventory_item:
				emit_signal("water_tree_pressed")
				#slot._remove_inventory_item()
			elif slot.tree_appearance == "cotton_candy_sapling"&& slot.inventory_item:
				emit_signal("cotton_candy_tree_pressed")
			elif slot.tree_appearance == "lightning_sapling"&& slot.inventory_item:
				emit_signal("lightning_tree_pressed")
			elif slot.tree_appearance == "bunny_sapling"&& slot.inventory_item:
				emit_signal("bunny_tree_pressed")
			elif slot.tree_appearance == "sand_sapling"&&slot.inventory_item:
				emit_signal("sand_tree_pressed")
			elif slot.tree_appearance == "bubble_sapling"&&slot.inventory_item:
				emit_signal("bubble_tree_pressed")
			elif slot.tree_appearance == "tree_sapling"&&slot.inventory_item:
				emit_signal("tree_tree_pressed")
			elif slot.tree_appearance == "laven_sapling"&&slot.inventory_item:
				emit_signal("laven_tree_pressed")
			elif slot.tree_appearance == "rain_sapling"&&slot.inventory_item:
				emit_signal("rain_tree_pressed")
			elif slot.tree_appearance == "marble_sapling"&&slot.inventory_item:
				emit_signal("marble_tree_pressed")
			else:
				print("not ready")
			last_slot_clicked = slot
			#print(last_slot_clicked)

func _add_to_inventory(type, inventory_item_name):
	for inv_slot in inventory_slots.get_children():
		if type == "sapling":
			if inv_slot.inventory_item && inv_slot.inventory_item.item_number == inventory_item_name:
				inv_slot._remove_inventory_item()
		if !inv_slot.inventory_item:
			inv_slot._add_inventory_item(type, inventory_item_name)
			print("add_inventory: " + inventory_item_name)
			break

func _remove_from_inventory():
	last_slot_clicked._remove_inventory_item()
	
func _remove_merged_seeds(old,other):
	print(old.get_node("SeedImage").texture)
	var seedData = ImportData.seed_data
	for inv_slot in inventory_slots.get_children():
		if inv_slot.inventory_item:
			if inv_slot.inventory_item.item_number != null:
				if seedData[inv_slot.inventory_item.item_number]["seedImage"] == old.get_node("SeedImage").texture:
					inv_slot._remove_inventory_item()
#				break
				
	for inv_slot in inventory_slots.get_children():
		if inv_slot.inventory_item:
			if inv_slot.inventory_item.item_number != null:
				if seedData[inv_slot.inventory_item.item_number]["seedImage"] == other.get_node("SeedImage").texture:
					inv_slot._remove_inventory_item()
#				break
				
func _remove_item_merge_seeds(old):
	var seedData = ImportData.seed_data
	for inv_slot in inventory_slots.get_children():
		if inv_slot.inventory_item:
			if inv_slot.inventory_item.item_number != null:
				if seedData[inv_slot.inventory_item.item_number]["seedImage"] == old.get_node("SeedImage").texture:
					inv_slot._remove_inventory_item()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
#func _input(event):
	#if event.is_action_pressed("ui_click"):
		#if tree_type != null:
			#var tree = TreeItemClass.instance()
			#add_child(tree)
			#tree._choose_tree(tree_type)
			#tree.set_position(Vector2(event.position.x,event.position.y))
			#tree_type = null
func _can_item_merge(type, item):
	var count = 0
	match (item):
		"rock":
			if !type == "bubble":
				return false
			else:
				for member in get_tree().get_nodes_in_group("seedGroup"):
					if member.seed_name == type:
						count+=1
		"lavender":
			if !type == "water":
				return false
			else:
				for member in get_tree().get_nodes_in_group("seedGroup"):
					if member.seed_name == type:
						count+=1
		"unidentified_grass":
			if !type == "magma":
				return false
			else:
				for member in get_tree().get_nodes_in_group("seedGroup"):
					if member.seed_name == type:
						count+=1
		"candy":
			if !type == "air":
				return false
			else:
				for member in get_tree().get_nodes_in_group("seedGroup"):
					if member.seed_name == type:
						count+=1
		"carrot":
			if !type == "air":
				return false
			else:
				for member in get_tree().get_nodes_in_group("seedGroup"):
					if member.seed_name == type:
						count+=1
	if count == 2:
		return true
	else:
		return false

			

func _can_merge(which,other):
	var seedData = ImportData.seed_data
	var count = 0
	if (which.seed_name == "fire" and other.seed_name == "earth") or (which.seed_name == "earth" and other.seed_name == "fire"):
		for member in get_tree().get_nodes_in_group("seedGroup"):
			if member.seed_name == "magma":
				return false
	elif (which.seed_name == "earth" and other.seed_name == "air") or (which.seed_name == "air" and other.seed_name == "earth"):
		for member in get_tree().get_nodes_in_group("seedGroup"):
			if member.seed_name == "sand":
				return false
	elif (which.seed_name == "fire" and other.seed_name == "air") or (which.seed_name == "air" and other.seed_name == "fire"):
		for member in get_tree().get_nodes_in_group("seedGroup"):
			if member.seed_name == "lightning":
				return false
	elif (which.seed_name == "air" and other.seed_name == "water") or (which.seed_name == "water" and other.seed_name == "air"):
		for member in get_tree().get_nodes_in_group("seedGroup"):
			if member.seed_name == "rain":
				return false
	elif (which.seed_name == "fire" and other.seed_name == "water") or (which.seed_name == "water" and other.seed_name == "fire"):
		for member in get_tree().get_nodes_in_group("seedGroup"):
			if member.seed_name == "bubble":
				return false
	elif (which.seed_name == "water" and other.seed_name == "earth") or (which.seed_name == "earth" and other.seed_name == "water"):
		for member in get_tree().get_nodes_in_group("seedGroup"):
			if member.seed_name == "tree":
				return false
	for inv_slot in inventory_slots.get_children():
		if inv_slot.inventory_item:
			print(str(inv_slot.inventory_item.item_number))
			if inv_slot.inventory_item.item_number != null:
				if seedData[inv_slot.inventory_item.item_number]["seedImage"] == which.get_node("SeedImage").texture or seedData[inv_slot.inventory_item.item_number]["seedImage"]== other.get_node("SeedImage").texture:
					count +=1
	print(str(count))
	if count == 4:
		return true
	else:
		return false
