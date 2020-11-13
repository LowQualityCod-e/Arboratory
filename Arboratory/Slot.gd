extends ColorRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal add_seed

# Called when the node enters the scene tree for the first time.
var InventoryItemClass = preload("res://InventoryItem.tscn")
var inventory_item = null
var tree_appearance
onready var tree_counter
func _ready():
	rect_min_size = Vector2(60,60)
	
func _add_inventory_item(type, inventory_item_name):
	if type == "sapling":
		inventory_item = InventoryItemClass.instance()
		inventory_item.tree_number = inventory_item_name
		add_child(inventory_item)
	elif type == "seed":
		inventory_item = InventoryItemClass.instance()
		inventory_item.item_name = inventory_item_name
		add_child(inventory_item)
		if inventory_item_name == "air":
			for member in get_tree().get_nodes_in_group("seedGroup"):
				if member.seed_name == "air":
					emit_signal("add_seed",member,"air")
					break
		elif inventory_item_name == "water":
			for member in get_tree().get_nodes_in_group("seedGroup"):
				if member.seed_name == "water":
					emit_signal("add_seed",member,"water")
					break
		elif inventory_item_name == "earth":
			for member in get_tree().get_nodes_in_group("seedGroup"):
				if member.seed_name == "earth":
					emit_signal("add_seed",member,"earth")
					break
		elif inventory_item_name == "fire":
			for member in get_tree().get_nodes_in_group("seedGroup"):
				if member.seed_name == "fire":
					emit_signal("add_seed",member,"fire")
					break
		elif inventory_item_name == "magma":
			for member in get_tree().get_nodes_in_group("seedGroup"):
				if member.seed_name == "magma":
					emit_signal("add_seed",member,"magma")
					break
		elif inventory_item_name == "snoop":
			for member in get_tree().get_nodes_in_group("seedGroup"):
				if member.seed_name == "snoop":
					emit_signal("add_seed",member,"snoop")
					break
		elif inventory_item_name == "cottoncandy":
			for member in get_tree().get_nodes_in_group("seedGroup"):
				if member.seed_name == "cottoncandy":
					emit_signal("add_seed",member,"cottoncandy")
					break
		elif inventory_item_name == "lightning":
			for member in get_tree().get_nodes_in_group("seedGroup"):
				if member.seed_name == "lightning":
					emit_signal("add_seed",member,"lightning")
					break
		elif inventory_item_name == "bunny":
			for member in get_tree().get_nodes_in_group("seedGroup"):
				if member.seed_name == "bunny":
					emit_signal("add_seed",member,"bunny")
					break
		elif inventory_item_name == "sand":
			for member in get_tree().get_nodes_in_group("seedGroup"):
				if member.seed_name == "sand":
					emit_signal("add_seed",member,"sand")
					break
		elif inventory_item_name == "bubble":
			for member in get_tree().get_nodes_in_group("seedGroup"):
				if member.seed_name == "bubble":
					emit_signal("add_seed",member,"bubble")
					break
		elif inventory_item_name == "tree":
			for member in get_tree().get_nodes_in_group("seedGroup"):
				if member.seed_name == "tree":
					emit_signal("add_seed",member,"tree")
					break
		elif inventory_item_name == "laven":
			for member in get_tree().get_nodes_in_group("seedGroup"):
				if member.seed_name == "laven":
					emit_signal("add_seed",member,"laven")
					break
		elif inventory_item_name == "rain":
			for member in get_tree().get_nodes_in_group("seedGroup"):
				if member.seed_name == "rain":
					emit_signal("add_seed",member,"rain")
					break
		elif inventory_item_name == "marble":
			for member in get_tree().get_nodes_in_group("seedGroup"):
				if member.seed_name == "marble":
					emit_signal("add_seed",member,"marble")
					break
	else:
		print("cannot be added")
	
	
	tree_appearance = inventory_item.tree_appearance
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _remove_inventory_item():
	remove_child(inventory_item)
	#var inventoryNode = find_parent("Inventory")
	#inventoryNode.add_child(inventory_item)
	inventory_item = null

