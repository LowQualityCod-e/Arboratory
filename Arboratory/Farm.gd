extends TileMap



signal plot_clicked
signal plant
signal new_farm
signal tree_removed
signal tree_control

var tile_size = get_cell_size()
var farm_size = Vector2(8,7)
var farm = []
var spot
var remove_tree
var planting_control
var planting_ready
var clearing_time
var watering_time
var open_menu
var plot_x = 0
var plot_y = 0
var tree_placement_x = 0
var tree_placement_y = 0



# Called when the node enters the scene tree for the first time.
func _ready():
	for x in range(farm_size.x):
		farm.append([])
		for y in range(farm_size.y):
			farm[x].append(false)
			
	planting_control = false
	planting_ready = false
	remove_tree = false
	clearing_time = false
	open_menu = false

#user is ready to plant a tree
func _ready_to_plant():
	planting_control = true
	planting_ready = true
	
#clears all farm plots
func _clear_plots():
	for x in range(farm_size.x):
		for y in range(farm_size.y):
			farm[x][y] = false
	get_tree().call_group("trees","queue_free")
	emit_signal("new_farm","New Farm")

#clears single plot
func _clear_single_plot():
	remove_tree = true
	
func _close_menu():
	open_menu = false
	emit_signal("plant", tree_placement_x, tree_placement_y, plot_x, plot_y)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#handles mouse-click
func _input(event):
	if Input.is_action_pressed("ui_click"):
		
		#checks if you clicked in the grid
		if event.position.x <1024:
				
			#checks your ready to alter the farm
			if planting_control == true:
				plot_x = int((event.position.x-45)/(64*2))
				plot_y = int((event.position.y-92)/(64*2))
				tree_placement_x = (((plot_x+1)*64)+45)+plot_x*64
				tree_placement_y = ((plot_y*128)+92) + (plot_y-32)
				print(str(plot_x))
				print(str(plot_y))
				print(str(tree_placement_x))
				print(str(tree_placement_y))
				
				#checks if you want to clear
				if clearing_time == true:
					emit_signal("plant",tree_placement_x,tree_placement_y,plot_x,plot_y)
				
					if remove_tree == true:
						#remove single tree
						if farm[plot_x][plot_y] != false:
							emit_signal("tree_removed","Tree Removed")
						farm[plot_x][plot_y] = false
						remove_tree = false
						
				elif watering_time:
					emit_signal("plant", tree_placement_x,tree_placement_y,plot_x,plot_y)
					
				elif farm[plot_x][plot_y] == false && planting_ready == true:
					#plant a new tree
					spot = "Tree planted in plot: " + str(plot_x) + "," + str(plot_y)
					farm[plot_x][plot_y] = true
					emit_signal("plot_clicked",spot)
					emit_signal("plant",tree_placement_x,tree_placement_y,plot_x,plot_y)
					planting_ready = false
				
				elif farm[plot_x][plot_y] == false && planting_ready == false:
					print("not ready")
			
				else:
				#a tree is already in this plot
					spot = "A tree is already here. Menu Open"
					emit_signal("plot_clicked",spot)
					emit_signal("tree_control")
					open_menu = true
					emit_signal("plant", tree_placement_x,tree_placement_y,plot_x,plot_y)
			
		
		
