extends Area2D
#A very gross script the further you go down.

"""
Declaring a lot of variables
"""
onready var pot = get_tree().get_root().find_node("Pot", true, false)
onready var Seeds = get_tree().get_root().find_node("Seeds", true, false).get_children()
onready var dragNode = get_parent()
onready var Slots = get_tree().get_root().find_node("BaseFarmGrid",true,false).get_node("Inventory/GridContainer").get_children()

signal clicked
signal planted
signal watered
signal unlocked
signal add_to_inventory
signal remove_from_inventory


var previous_mouse_position = Vector2()
var is_dragging = false
var seeded = false
var planted = 0
var is_pot_vacant = true
var seed_to_merge1
var seed_to_merge2
var old_merged_seed
var time_to_merge  = false
var seed_pos
var seed_pos1
var seed_pos2
var seed_name
var sapling_name
var merge_event = false


func _ready():
	pot.connect("seeded",self,"changeSeed")
	for Slot in Slots:
		Slot.connect("add_seed",self,"_revert_seed")
	
		
	

"""
When a seed enters a shape it checks if its a pot
If it is, and it is empty, it tells the Merge Area Script its been planted and sets 
vacancy to false. If not empty, it sets vacancy to true so that vacancy will still be false on exiting.
If it is not a pot, it puts the seed back in its spot.
"""
func _on_aSeeds_area_shape_entered(area_id, area, area_shape, self_shape):
	var isPot = area.get_name()
	if isPot == "Pot":
		if is_pot_vacant:
			position = Vector2(960,595.5)
			is_dragging = false
			emit_signal("planted",self)
			#is_pot_vacant = false
			get_tree().set_group("seedGroup","is_pot_vacant",false)
			get_tree().set_group("seedGroup","seed_to_merge1",self) ##
			get_tree().set_group("seedGroup","old_merged_seed",self) ##
		else:
#			self.set_position(seed_pos)
			is_dragging = false
			get_tree().set_group("seedGroup","is_pot_vacant",!is_pot_vacant)
			seed_to_merge2 = self ##
			time_to_merge  = true ##
			_merge(seed_to_merge1,seed_to_merge2,old_merged_seed) ##
			
	else:
		var counter = 0
		for member in get_tree().get_nodes_in_group("seedGroup"):
			if member != self && member.seed_pos == self.seed_pos1:
				counter+=1
		if !counter ==0:
			self.seed_pos = seed_pos2
			self.set_position(seed_pos2)
		else:
			self.seed_pos = seed_pos1
			self.set_position(seed_pos1)
		is_dragging = false
	

"""
When a seed is removed it tells the Merge Area Script that its gone and sets vacancy to false if 
pot not empty or true if pot is empty.	
"""

func _on_aSeeds_area_shape_exited(area_id, area, area_shape, self_shape):
	var isPot = area.get_name()
	if isPot == "Pot":
		if is_pot_vacant == false:
			emit_signal("planted",self)
		get_tree().set_group("seedGroup","is_pot_vacant",!is_pot_vacant)
		if merge_event:
			get_tree().set_group("seedGroup","is_pot_vacant", true)
			get_tree().set_group("seedGroup","merge_event",false)
		
"""
The watered function starts the growth process by sending a signal to Merge Area Script.
"""
func _on_water_area_shape_entered(area_id, area, area_shape, self_shape):
	var isPot = area.get_name()
	if isPot == "Pot":
		position = Vector2(1400,200)
		emit_signal("watered")
		is_dragging = false

"""
The change seed function gets a signal when a pot is both watered and planted.
It then will find the seed location in the dictionary and change the art.
It will also add the sapling to the inventory and unlock the type in the dex.
"""

func changeSeed(which):
	var seedData = ImportData.seed_data
	if time_to_merge == false:
		for key in seedData:
			if seedData[key]["seedImage"] == which.get_node("SeedImage").texture:
				which.get_node("SeedImage").texture = load(seedData[key]["saplingImage"])
				print(self)
				emit_signal("unlocked", key)
				emit_signal("add_to_inventory","sapling",key)
				
	
"""
When clicked on,
can be moved around the screen
"""

func _on_draggable_input_event(viewport, event, shape_idx):
	
	"""
	Allows dragging if the user clicks inside
	the collision shape
	"""
	if event.is_action_pressed("ui_touch"):
		print(event)
		get_tree().set_input_as_handled()
		previous_mouse_position = event.position
		is_dragging = true
		emit_signal("clicked")


func _input(event):
	
	"""
	Works globally so dragging works if
	mouse cursor is outside of Collision Shape
	Disables dragging if the user releases click
	"""
	
	if not is_dragging:
		return
	
	if event.is_action_released("ui_touch"):
		previous_mouse_position = Vector2()
		is_dragging = false
	
	
	if is_dragging and event is InputEventMouseMotion:
		position += event.position - previous_mouse_position
		previous_mouse_position = event.position
		
#func _revert_seed(aSeed,which):
func _revert_seed(aSeed,which):
	aSeed.get_node("SeedImage").texture = load("res://Assets/Plants/seeds/"+which+"_seed.png")
	emit_signal("remove_from_inventory")
	

#func _connect_newSeed(newSeed):
	#newSeed.connect("area_shape_entered",self,"_on_aSeeds_area_shape_entered")
	#newSeed.connect("area_shape_exited",self,"_on_aSeeds_area_shape_exited")
func _merge(which, other,old):
	if time_to_merge == true && get_tree().get_root().find_node("Inventory",true,false)._can_merge(which,other) == true:
		get_tree().get_root().find_node("Inventory",true,false)._remove_merged_seeds(old,other)
		match(which.seed_name):
			"air":
				match(other.seed_name):
					"earth":
						get_tree().get_root().find_node("Planting",true,false)._new_seed("sand",1)
					"water":
						get_tree().get_root().find_node("Planting",true,false)._new_seed("lightning",1)
					"fire":
						get_tree().get_root().find_node("Planting",true,false)._new_seed("lightning",1)
					_:
						print("fail")
			"earth":
				match(other.seed_name):
					"fire":
						get_tree().get_root().find_node("Planting",true,false)._new_seed("magma",1)
					"water": 
						get_tree().get_root().find_node("Planting",true,false)._new_seed("tree",1)
					"air":
						get_tree().get_root().find_node("Planting",true,false)._new_seed("sand",1)
					_:
						print("fail")
			"fire":
				match(other.seed_name):
					"air":
						get_tree().get_root().find_node("Planting",true,false)._new_seed("lightning",1)
					"earth":
						get_tree().get_root().find_node("Planting",true,false)._new_seed("magma",1)
					"water":
						get_tree().get_root().find_node("Planting",true,false)._new_seed("bubble",1)
					_:
						print("fail")
			"water":
				match(other.seed_name):
					"fire":
						get_tree().get_root().find_node("Planting",true,false)._new_seed("bubble",1)
					"earth":
						get_tree().get_root().find_node("Planting",true,false)._new_seed("tree",1)
					"air":
						 get_tree().get_root().find_node("Planting",true,false)._new_seed("lightning",1)
					_:
						print("fail")
			_:
				print("fail")
		time_to_merge  = false
		merge_event = true
			
		which.queue_free()
		#get_tree().set_group("seedGroup","is_pot_vacant",!is_pot_vacant)
		self.queue_free()
		get_tree().call_group("seedGroup","show")
		
		emit_signal("planted",self)
		
	else:
		var counter = 0
		for member in get_tree().get_nodes_in_group("seedGroup"):
			if member != self && member.seed_pos == self.seed_pos1:
				counter+=1
		if !counter ==0:
			self.seed_pos = seed_pos2
			self.set_position(seed_pos2)
		else:
			self.seed_pos = seed_pos1
			self.set_position(seed_pos1)
		is_dragging = false
		
