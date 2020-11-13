extends Node2D


"""
Not sure what the comments are here but puts the air, fire, water, earth seed 
into the game.
"""
#Currently just chaning one of the seeds to the lavender seed
#Planned to be the start up / save feature of the game
func _ready():
#	$arboretumBackground.show()
#	$labBackground.hide()
#	$Pot.hide()
#	$water.hide()
#	$treeDex_button.hide()
#	$FarmButton.hide()
#	$PauseButton.hide()
#	$Seeds/mergeBackground1.hide()
#	$Seeds/mergeBackground2.hide()
	
	_new_seed("air",1)
	_new_seed("water",1)
	_new_seed("earth",1)
	_new_seed("fire",1)
	get_tree().call_group("seedGroup","hide")
	pass 

"""
Adds a new seed into the merging area. Pass in the type of seed and the number
to be added.
A new seed is an aSeeds instance and is connected to the Pot. It is also added 
into the seedGroup, given its texture, its name, and assigned a spot on the screen.
BaseFarmGrid will call this also to add seeds.
"""
func _new_seed(type, number):
	for x in range(number):
		var seedling = load("res://aSeeds.tscn").instance()
		seedling.seed_name = type
		seedling.connect("planted",$Pot,"planted")
		add_child(seedling)
		seedling.add_to_group("seedGroup")
		#get_tree().call_group("seedGroup","hide")
		match (type):
			"air":
				seedling.get_node("SeedImage").texture= load("res://Assets/Plants/seeds/air_seed.png")
				seedling.seed_pos1 = Vector2(240,280)
				seedling.seed_pos = seedling.seed_pos1
				seedling.set_position(Vector2(240,280))

				seedling.seed_pos2 = Vector2(240,400)
				
			"earth":
				seedling.get_node("SeedImage").texture= load("res://Assets/Plants/seeds/earth_seed.png")
				seedling.seed_pos1 = Vector2(360,280)
				seedling.seed_pos = seedling.seed_pos1
				seedling.set_position(Vector2(360,280))
				seedling.seed_pos2 = Vector2(360,400)
				
			"fire":
			#$Seeds.get_node("newSeed").get_node("SeedImage").texture= load("res://Assets/Plants/seeds/fire_seed.png")
				seedling.get_node("SeedImage").texture = load("res://Assets/Plants/seeds/fire_seed.png")
				seedling.seed_pos1 = Vector2(480,280)
				seedling.seed_pos = seedling.seed_pos1
				seedling.set_position(Vector2(480,280))
				seedling.seed_pos2 = Vector2(480,400)
				
			"water":
				seedling.get_node("SeedImage").texture= load("res://Assets/Plants/seeds/water_seed.png")
				seedling.seed_pos1 = Vector2(600,280)
				seedling.seed_pos = seedling.seed_pos1
				seedling.set_position(Vector2(600,280))
				seedling.seed_pos2 = Vector2(600,400)

			"bunny":
				seedling.get_node("SeedImage").texture= load("res://Assets/Plants/seeds/bunny_seed.png")
				seedling.seed_pos1 = Vector2(240,520)
				seedling.seed_pos = seedling.seed_pos1
				seedling.set_position(Vector2(240,520))
				seedling.seed_pos2 = Vector2(240,640)

			"lightning":
				seedling.get_node("SeedImage").texture= load("res://Assets/Plants/seeds/lightning_seed.png")
				seedling.seed_pos1 = Vector2(360,520)
				seedling.seed_pos = seedling.seed_pos1
				seedling.set_position(Vector2(360,520))
				seedling.seed_pos2 = Vector2(360,640)

			"cottoncandy":
				seedling.get_node("SeedImage").texture= load("res://Assets/Plants/seeds/cotton_candy_seed.png")
				seedling.seed_pos1 = Vector2(480,520)
				seedling.seed_pos = seedling.seed_pos1
				seedling.set_position(Vector2(480,520))
				seedling.seed_pos2 = Vector2(480,640)
				
			"magma":
				seedling.get_node("SeedImage").texture= load("res://Assets/Plants/seeds/magma_seed.png")
				seedling.seed_pos1 = Vector2(600,520)
				seedling.seed_pos = seedling.seed_pos1
				seedling.set_position(Vector2(600,520))
				seedling.seed_pos2 = Vector2(600,640)

			"snoop":
				seedling.get_node("SeedImage").texture= load("res://Assets/Plants/seeds/snoop_dogg_seed.png")
				seedling.seed_pos1 = Vector2(240,760)
				seedling.seed_pos = seedling.seed_pos1
				seedling.set_position(Vector2(240,760))
				seedling.seed_pos2 = Vector2(240,880)

			"sand":
				seedling.get_node("SeedImage").texture= load("res://Assets/Plants/seeds/sand_seed.png")
				seedling.seed_pos1 = Vector2(360,760)
				seedling.seed_pos = seedling.seed_pos1
				seedling.set_position(Vector2(360,760))
				seedling.seed_pos2 = Vector2(360,880)

			"bubble":
				seedling.get_node("SeedImage").texture = load("res://Assets/Plants/seeds/bubble_seed.png")
				seedling.seed_pos1 = Vector2(480,760)
				seedling.seed_pos = seedling.seed_pos1
				seedling.set_position(Vector2(480,760))
				seedling.seed_pos2 = Vector2(480,880)
				
			"tree":
				seedling.get_node("SeedImage").texture = load("res://Assets/Plants/seeds/tree_seed.png")
				seedling.seed_pos1 = Vector2(600,760)
				seedling.seed_pos = seedling.seed_pos1
				seedling.set_position(Vector2(600,760))
				seedling.seed_pos2 = Vector2(600,880)
			"laven":
				seedling.get_node("SeedImage").texture = load("res://Assets/Plants/seeds/laven_seed.png")
				seedling.seed_pos1 = Vector2(1300,520)
				seedling.seed_pos = seedling.seed_pos1
				seedling.set_position(Vector2(1300,520))
				seedling.seed_pos2 = Vector2(1300,640)
			"rain":
				seedling.get_node("SeedImage").texture = load("res://Assets/Plants/seeds/rain_seed.png")
				seedling.seed_pos1 = Vector2(1420,520)
				seedling.seed_pos = seedling.seed_pos1
				seedling.set_position(Vector2(1420,520))
				seedling.seed_pos2 = Vector2(1420,640)
			"marble":
				seedling.get_node("SeedImage").texture = load("res://Assets/Plants/seeds/marble_seed.png")
				seedling.seed_pos1 = Vector2(1540,520)
				seedling.seed_pos = seedling.seed_pos1
				seedling.set_position(Vector2(1540,520))
				seedling.seed_pos2 = Vector2(1540,640)
				
		seedling.hide()


			
		
"""
Shows the dex and pauses the rest of the game when the dex button is pressed.
"""
		

func _on_treeDex_button_pressed():
	$treeDex.show()
	get_tree().call_group("seedGroup","hide")
	get_tree().call_group("mergeGroup","hide")
	get_tree().paused = true

"""
Switches scenes to the BaseFarmGrid when the farm button is pressed, 
pausing (sort of) the rest of the game and unpausing the farm.
Shows the Farm and Inventory and hides the rest.
"""
func _on_FarmButton_pressed():
	$BaseFarmGrid._unpause()
	$BaseFarmGrid/Inventory/TextureRect.show()
	$BaseFarmGrid/Inventory/GridContainer.show()
	$BaseFarmGrid/Farm.show()
	$BaseFarmGrid/PlantingNotifier/ClearPlots.show()
	$BaseFarmGrid/PlantingNotifier/ExitFarm.show()
	$BaseFarmGrid/PlantingNotifier/PlantingNotifierMessage.show()
	$BaseFarmGrid/PlantingNotifier/ProgressBar.show()
	$labBackground.hide()
	$arboretumBackground.show()
	#$BaseFarmGrid/PlantingNotifier/treeDex_button2.show()
	$Pot.hide()
	$water.hide()
	$treeDex_button.hide()
	$FarmButton.hide()
	$PauseButton.hide()
	$Seeds/mergeBackground1.hide()
	$Seeds/mergeBackground2.hide()
	
	get_tree().call_group("seedGroup","hide")
	get_tree().call_group("mergeGroup","hide")
	#get_tree().call_group("soilPlots","show")
	
"""
Returns to the merge area from the BaseFarmGrid when the return button is pressed,
unpausing (sort of) the rest of the game and pausing the farm.
Shows seeds and pot and hides Farm and Inventory.
Makes sure to close any open tree menu
"""
func _return_to_planting():
	$Pot.show()
	$water.show()
	$treeDex_button.show()
	$FarmButton.show()
	$PauseButton.show()
	get_tree().call_group("seedGroup","show")
	get_tree().call_group("mergeGroup","show")
	#get_tree().call_group("soilPlots","hide")
	$BaseFarmGrid._pause()
	$BaseFarmGrid/PlantingNotifier/ClearSinglePlot.hide()
	$BaseFarmGrid/PlantingNotifier/Return.hide()
	$BaseFarmGrid/PlantingNotifier/Water.hide()
	$BaseFarmGrid/PlantingNotifier/ProgressBar.hide()
	$labBackground.show()
	$Seeds/mergeBackground1.show()
	$Seeds/mergeBackground2.show()
	$arboretumBackground.hide()
	#$BaseFarmGrid/PlantingNotifier/treeDex_button2.hide()
	$BaseFarmGrid/Farm._close_menu()


func _on_PauseButton_pressed():
	PauseMenu.pauseGame()

func _new_merge_item(type):
	var mergeItem = load("res://MergeItem.tscn").instance()
	add_child(mergeItem)
	mergeItem.seed_name = type
	mergeItem.add_to_group("mergeGroup")
	match (type):
		"carrot":
			mergeItem.get_node("Sprite").texture= load("res://Assets/Art/carrot.png")
			mergeItem.seed_pos = Vector2(1300,280)
			mergeItem.set_position(Vector2(1300,280))
		"unidentified_grass":
			mergeItem.get_node("Sprite").texture = load("res://Assets/Art/unidentified_grass.png")
			mergeItem.seed_pos = Vector2(1420,280)
			mergeItem.set_position(Vector2(1420,280))
		"candy":
			mergeItem.get_node("Sprite").texture = load("res://Assets/Art/candy.png")
			mergeItem.seed_pos = Vector2(1540,280)
			mergeItem.set_position(Vector2(1540,280))
		"lavender":
			mergeItem.get_node("Sprite").texture = load("res://Assets/Art/lavender.png")
			mergeItem.seed_pos = Vector2(1660,280)
			mergeItem.set_position(Vector2(1660,280))
		"rock":
			mergeItem.get_node("Sprite").texture = load("res://Assets/Art/rock.png")
			mergeItem.seed_pos = Vector2(1300,400)
			mergeItem.set_position(Vector2(1300,400))
	mergeItem.hide()
