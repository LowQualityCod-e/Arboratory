extends Node

export (PackedScene) var Tree

var anim
var free_tree
var trees = []
var trees_size = Vector2(8,7)
var ready_to_clear_plot
var watering_time
var max_seed = 0


const DEFAULT_SUNLIGHT = 1

signal return_to_planting
signal add_seeds

"""
Hides the farm in the beginning and creates the plots with a 2D array and
sets the farm position.
Sets the variables for clearing and watering to false.
"""
func _ready():
	$Farm.hide()
	$Inventory/TextureRect.hide()
	$Inventory/GridContainer.hide()
	$Farm.position.x = 45
	$Farm.position.y = 92
	$Farm.scale.x = 2
	$Farm.scale.y = 2

	
	for x in range(trees_size.x):
		trees.append([])
		for y in range(trees_size.y):
			trees[x].append(null)
	ready_to_clear_plot = false
	watering_time = false

func _process(delta):
	"""
	Loop through tree array and have every tree execute their special power.
	For now, just the rain tree (can water other trees).
	
	Also, calculate the sunlight level for each tree based on the types of trees
	around it.
	"""
	for x in trees_size.x:
		for y in trees_size.y:
			#For each tree, call special power
			if trees[x][y] != null:
				trees[x][y]._special_power()
				#For each tree, look at trees around it and calculate sunlight
				trees[x][y].sunlight = _calculate_sunlight(x, y)

"""
Looks at the trees in a 3x3 grid around the selected tree and returns the amount
of sunlight the 
"""
func _calculate_sunlight(x, y):
	var sunlight = DEFAULT_SUNLIGHT
	for i in range(x-1, x + 2):
			for j in range(y-1, y + 2):
				#Check that indices are within range
				if (i >= 0 and i < trees_size.x \
				and j >= 0 and j < trees_size.y \
				and trees[i][j] != null \
				and !trees[i][j].dead):
					#Snoop tree increases sunlight
					if(trees[i][j].treeName == "snoop"):
						sunlight += 1
	return sunlight
	
#handles removing and planting of trees
func _plant_tree(pos_x,pos_y,plot_x,plot_y):
	if free_tree == true:
		if trees[plot_x][plot_y]!= null:
			#print(str(trees[plot_x][plot_y].treeName))
			ready_to_clear_plot = true
			_new_plot()
			if trees[plot_x][plot_y].dead == false and trees[plot_x][plot_y].tree_maturity == "Mature":
				match(trees[plot_x][plot_y].treeName):
							"bunny":
								for member in get_tree().get_nodes_in_group("seedGroup"):
									if member.seed_name == "bunny":
										max_seed+=1
							"lightning":
								for member in get_tree().get_nodes_in_group("seedGroup"):
									if member.seed_name == "lightning":
										max_seed+=1
							"sand":
								for member in get_tree().get_nodes_in_group("seedGroup"):
									if member.seed_name == "sand":
										max_seed+=1
							"air":
								for member in get_tree().get_nodes_in_group("seedGroup"):
									if member.seed_name == "air":
										max_seed+=1
							"cottoncandy":
								for member in get_tree().get_nodes_in_group("seedGroup"):
									if member.seed_name == "cottoncandy":
										max_seed+=1
							"earth":
								for member in get_tree().get_nodes_in_group("seedGroup"):
									if member.seed_name == "earth":
										max_seed+=1
							"fire":
								for member in get_tree().get_nodes_in_group("seedGroup"):
									if member.seed_name == "fire":
										max_seed+=1
							"magma":
								for member in get_tree().get_nodes_in_group("seedGroup"):
									if member.seed_name == "magma":
										max_seed+=1
							"snoop":
								for member in get_tree().get_nodes_in_group("seedGroup"):
									if member.seed_name == "snoop":
										max_seed+=1
							"water":
								for member in get_tree().get_nodes_in_group("seedGroup"):
									if member.seed_name == "water":
										max_seed+=1	

							"bubble":
								for member in get_tree().get_nodes_in_group("seedGroup"):
									if member.seed_name == "bubble":
										max_seed+=1
							"tree":
								for member in get_tree().get_nodes_in_group("seedgroup"):
									if member.seed_name == "tree":
										max_seed+=1
				max_seed+=1

				Leveling.gain_xp(2)

				if max_seed %2 == 0:
					print("YAY")
					for z in range(2):
						$Inventory._add_to_inventory("seed",trees[plot_x][plot_y].treeName)
					emit_signal("add_seeds",trees[plot_x][plot_y].treeName,1)
					
				else:
					print("NO")
					$Inventory._add_to_inventory("seed",trees[plot_x][plot_y].treeName)	
					max_seed+=1			
				
					
					
				
			else:
				$Inventory._add_to_inventory("seed",trees[plot_x][plot_y].treeName)
			trees[plot_x][plot_y]._remove_tree()
			trees[plot_x][plot_y] = null
			free_tree = false
			$Farm.clearing_time = false
			ready_to_clear_plot = false
			#print($Inventory.last_slot_clicked)
			
	
	elif watering_time:
		if trees[plot_x][plot_y]!= null:
			trees[plot_x][plot_y]._water_tree()
			watering_time = false
			$Farm.watering_time = false
		else:
			watering_time = false
			$Farm.watering_time = false
	
	elif trees[plot_x][plot_y] != null:
		if $Farm.open_menu == true:
			#$Inventory/TextureRect.hide()
			#$Inventory/GridContainer.hide()
			for x in range(trees_size.x):
				for y in range(trees_size.y):
					if trees[x][y] != null:
						trees[x][y]._hide_stats()
						print("tree here")
			trees[plot_x][plot_y]._show_stats()
		else:
			trees[plot_x][plot_y]._hide_stats()
			print("stats hidden")
			
	elif $Farm.planting_ready == true:
		print("new tree incoming")
		var tree = Tree.instance()
		add_child(tree)
		trees[plot_x][plot_y] = tree
		tree.tree_x_index = plot_x
		tree.tree_y_index = plot_y
		tree.position.x = pos_x
		tree.position.y = pos_y
		tree._choose_tree(anim)
		tree.connect("_water_tree_from_tree", self, "_water_tree_from_tree")
		#sets default sunlight level to 1
		tree.sunlight = DEFAULT_SUNLIGHT
		$Inventory._remove_from_inventory()
		
	else:
		print("not ready")
	

		
		
#handles choosing the tree you want to plant
func _select_tree(type):
	if type == "water_tree":
		anim = "water_sapling"
	if type == "fire_tree":
		anim = "fire_sapling"
	if type == "earth_tree":
		anim = "earth_sapling"
	if type == "air_tree":
		anim = "air_sapling"
	if type == "magma_tree":
		anim = "magma_sapling"
	if type == "snoop_tree":
		anim = "snoop_sapling"
	if type == "cotton_candy_tree":
		anim = "cotton_candy_sapling"
	if type == "lightning_tree":
		anim = "lightning_sapling"
	if type == "bunny_tree":
		anim = "bunny_sapling"
	if type == "sand_tree":
		anim = "sand_sapling"
	if type == "bubble_tree":
		anim = "bubble_sapling"
	if type == "tree_tree":
		anim = "tree_sapling"
	$Farm._ready_to_plant()
	$Farm.clearing_time = false
	free_tree = false
	

#clears all plots		
func _new_farm():
	for x in trees_size.x:
		for y in trees_size.y:
			if trees[x][y]!= null:
				if trees[x][y].dead == false and trees[x][y].tree_maturity == "Mature":
						match(trees[x][y].treeName):
							"bunny":
								for member in get_tree().get_nodes_in_group("seedGroup"):
									if member.seed_name == "bunny":
										max_seed+=1
							"lightning":
								for member in get_tree().get_nodes_in_group("seedGroup"):
									if member.seed_name == "lightning":
										max_seed+=1
							"sand":
								for member in get_tree().get_nodes_in_group("seedGroup"):
									if member.seed_name == "sand":
										max_seed+=1
							"air":
								for member in get_tree().get_nodes_in_group("seedGroup"):
									if member.seed_name == "air":
										max_seed+=1
							"cottoncandy":
								for member in get_tree().get_nodes_in_group("seedGroup"):
									if member.seed_name == "cottoncandy":
										max_seed+=1
							"earth":
								for member in get_tree().get_nodes_in_group("seedGroup"):
									if member.seed_name == "earth":
										max_seed+=1
							"fire":
								for member in get_tree().get_nodes_in_group("seedGroup"):
									if member.seed_name == "fire":
										max_seed+=1
							"magma":
								for member in get_tree().get_nodes_in_group("seedGroup"):
									if member.seed_name == "magma":
										max_seed+=1
							"snoop":
								for member in get_tree().get_nodes_in_group("seedGroup"):
									if member.seed_name == "snoop":
										max_seed+=1
							"water":
								for member in get_tree().get_nodes_in_group("seedGroup"):
									if member.seed_name == "water":
										max_seed+=1	
							"bubble":
								for member in get_tree().get_nodes_in_group("seedGroup"):
									if member.seed_name == "bubble":
										max_seed+=1
							"tree":
								for member in get_tree().get_nodes_in_group("seedGroup"):
									if member.seed_name == "tree":
										max_seed+=1
						max_seed+=1
						print(str(max_seed))
						Leveling.gain_xp(2)
						if max_seed %2 == 0:
							for z in range(2):
								$Inventory._add_to_inventory("seed",trees[x][y].treeName)
							emit_signal("add_seeds",trees[x][y].treeName,1)
							
						else:
							$Inventory._add_to_inventory("seed",trees[x][y].treeName)
							max_seed+=1
				else:
					$Inventory._add_to_inventory("seed",trees[x][y].treeName)
	$Farm._clear_plots()
	
#clears a single plot
func _new_plot():
	if ready_to_clear_plot == true:
		$Farm._clear_single_plot()
	else:
		free_tree = true
		$Farm.clearing_time = true
		
func _water_tree():
	$Farm.watering_time = true
	watering_time = true
	print("watering time")
	
"""
When a tree emits this signal, waters the tree in the specific plot.
"""	
func _water_tree_from_tree(plot_x, plot_y):
	if (plot_x < trees_size.x and plot_y < trees_size.y \
		and plot_x >= 0 and plot_y >=0 and trees[plot_x][plot_y] != null):
			trees[plot_x][plot_y]._water_tree()
			#watering_time = false
			#$Farm.watering_time = false



func _open_inventory():
	$Inventory/TextureRect.show()
	$Inventory/GridContainer.show()
	
func _exit_farm():
	$Inventory/TextureRect.hide()
	$Inventory/GridContainer.hide()
	$Farm.hide()
	$PlantingNotifier/ClearPlots.hide()
	$PlantingNotifier/ExitFarm.hide()
	$PlantingNotifier/PlantingNotifierMessage.hide()
	emit_signal("return_to_planting")

func _pause():
	for x in range(trees_size.x):
		for y in range(trees_size.y):
			if trees[x][y]!=null:
				trees[x][y].hide()
				trees[x][y].set_process_input(pause_mode)
				#trees[x][y].set_process_internal(pause_mode)
	$Farm.set_process_input(pause_mode)
				
func _unpause():
	for x in range(trees_size.x):
		for y in range(trees_size.y):
			if trees[x][y]!=null:
				trees[x][y].show()
				trees[x][y].set_process_input(!pause_mode)
	$Farm.set_process_input(!pause_mode)


