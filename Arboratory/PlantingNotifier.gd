extends CanvasLayer

signal plant_fire
signal plant_water
signal plant_air
signal plant_magma
signal plant_earth
signal plant_snoop
signal plant_cotton_candy
signal plant_lightning
signal plant_bunny
signal plant_sand
signal plant_bubble
signal plant_tree
signal clear
signal clear_single
signal water_tree
signal close_menu
signal exit_farm

# Called when the node enters the scene tree for the first time.
func _ready():
	var dynamic_font = DynamicFont.new()
	dynamic_font.font_data = load("res://Fonts/Lato-Regular.ttf")
	dynamic_font.size = 43
	#$WaterTree.set_position(Vector2(900,40))
	#$WaterTree.add_font_override("font",dynamic_font)
	#$FireTree.set_position(Vector2(900,100))
	#$FireTree.add_font_override("font",dynamic_font)
	#$EarthTree.set_position(Vector2(900,160))
	#$EarthTree.add_font_override("font",dynamic_font)
	#$AirTree.set_position(Vector2(900,220))
	#$AirTree.add_font_override("font",dynamic_font)
	#$MagmaTree.set_position(Vector2(900,280))
	#$MagmaTree.add_font_override("font",dynamic_font)
	#$SnoopTree.set_position(Vector2(900,340))
	#$SnoopTree.add_font_override("font",dynamic_font)
	$WaterTree.hide()
	$FireTree.hide()
	$EarthTree.hide()
	$AirTree.hide()
	$MagmaTree.hide()
	$SnoopTree.hide()
	$ClearPlots.set_position(Vector2(1370,640))
	#$ClearPlots.add_font_override("font",dynamic_font)
	$ClearPlots.hide()
	$ClearSinglePlot.set_position(Vector2(1370,640))
	#$ClearSinglePlot.add_font_override("font",dynamic_font)
	$ClearSinglePlot.hide()
	$PlantingNotifierMessage.set_position(Vector2(1305,510))
	#$PlantingNotifierMessage.add_font_override("font",dynamic_font)
	$Return.set_position(Vector2(1530,640))
	#$Return.add_font_override("font",dynamic_font)
	$Return.hide()
	$Water.set_position(Vector2(1210,640))
	#$Water.add_font_override("font",dynamic_font)
	$Water.hide()
	$PlantingNotifierMessage.hide()
	$ExitFarm.set_position(Vector2(1370,570))
	#$ExitFarm.set_text("Exit Farm")
	$ExitFarm.hide()
	$treeDex_button2.set_position(Vector2(750,15))
	$treeDex_button2.hide()
	$CottonCandyTree.hide()
	$LightningTree.hide()
	$BunnyTree.hide()
	$SandTree.hide()
	$BubbleTree.hide()
	$TreeTree.hide()
	$ProgressBar.hide()
	
#updates the planting message
func show_message(text):
	$PlantingNotifierMessage.text = text
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

#choosing a water tree
func _on_WaterTree_pressed():
	#$WaterTree.show()
	#$FireTree.show()
	#$MagmaTree.show()
	#$AirTree.show()
	#$EarthTree.show()
	emit_signal("plant_water","water_tree")

#choosing a fire tree
func _on_FireTree_pressed():
	#$FireTree.show()
	#$WaterTree.show()
	#$MagmaTree.show()
	#$AirTree.show()
	#$EarthTree.show()
	emit_signal("plant_fire","fire_tree")

#choosing an earth tree
func _on_EarthTree_pressed():
	#$EarthTree.show()
	#$WaterTree.show()
	#$FireTree.show()
	#$MagmaTree.show()
	#$AirTree.show()
	emit_signal("plant_earth","earth_tree")
	

#choosing an air tree
func _on_AirTree_pressed():
	#$AirTree.show()
	#$EarthTree.show()
	#$WaterTree.show()
	#$FireTree.show()
	#$MagmaTree.show()
	emit_signal("plant_air","air_tree")

#choosing a magma tree
func _on_MagmaTree_pressed():
	#$MagmaTree.show()
	#$AirTree.show()
	#$EarthTree.show()
	#$WaterTree.show()
	#$FireTree.show()
	emit_signal("plant_magma","magma_tree")
	
func _on_SnoopTree_pressed():
	#$AirTree.show()
	#$MagmaTree.show()
	#$EarthTree.show()
	#$WaterTree.show()
	#$FireTree.show()
	emit_signal("plant_snoop","snoop_tree")
	
func _on_CottonCandyTree_pressed():
	emit_signal("plant_cotton_candy", "cotton_candy_tree")
	
func _on_LightningTree_pressed():
	emit_signal("plant_lightning", "lightning_tree")
	
func _on_BunnyTree_pressed():
	emit_signal("plant_bunny", "bunny_tree")
	
func _on_SandTree_pressed():
	emit_signal("plant_sand","sand_tree")
	
func _on_BubbleTree_pressed():
	emit_signal("plant_bubble","bubble_tree")
	
func _on_TreeTree_pressed():
	emit_signal("plant_tree","tree_tree")

#clear all plots
func _on_ClearPlots_pressed():
	emit_signal("clear")

#clear single plot
func _on_ClearSinglePlot_pressed():
	emit_signal("clear_single")

func _open_tree_control_menu():
	print("menu opened")
	$AirTree.hide()
	$WaterTree.hide()
	$EarthTree.hide()
	$FireTree.hide()
	$MagmaTree.hide()
	$SnoopTree.hide()
	$BubbleTree.hide()
	$TreeTree.hide()
	$ClearPlots.hide()
	$ClearSinglePlot.show()
	$Return.show()
	$Water.show()
	


func _on_Return_pressed():
	#$AirTree.show()
	#$EarthTree.show()
	#$WaterTree.show()
	#$FireTree.show()
	#$MagmaTree.show()
	#$SnoopTree.show()
	$ClearPlots.show()
	$ClearSinglePlot.hide()
	$Return.hide()
	$Water.hide()
	emit_signal("close_menu")


func _on_Water_pressed():
	emit_signal("water_tree")
	
func _on_treeDex_button2_pressed():
	$treeDex.show()
	get_tree().call_group("seedGroup","hide")
	get_tree().paused = true


func _on_ExitFarm_pressed():
	emit_signal("exit_farm")



