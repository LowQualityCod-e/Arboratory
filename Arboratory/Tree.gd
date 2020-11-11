extends Area2D

"""
Variables relating to water functionality.
"""
const TIME_UNTIL_DRY = 10
const MAX_HEALTH = 100
var last_watering_time = OS.get_unix_time()
var health = 100
var healthDeduction = 1
var treeName
var wetness = "Wet"
var time_passed_since_watering = OS.get_unix_time() - last_watering_time

var tree_x_index
var tree_y_index
signal _water_tree_from_tree

"""
Variables relating to sunlight
"""
#sunlight level, speeds up growth when greater than 1
var sunlight

"""
Variables relating to growth
"""
#15 min of in-game time must pass before tree is grown
var time_until_grown
var time_planted
var tree_maturity = "Sapling"
var special_property

"""
Variables relating to death
"""
var dead = false


# Called when the node enters the scene tree for the first time.
func _ready():
	var dynamic_font = DynamicFont.new()
	dynamic_font.font_data = load("res://Fonts/Lato-Regular.ttf")
	dynamic_font.size = 20
	var v_gap = 25
	var text_start = 175
	$TreeStats/TreeStatPanel.set_position(Vector2(1300,170))
	$TreeStats/TreeStatPanel.set_size(Vector2(300,300))
	$TreeStats/TreeStatPanel.hide()
	$TreeStats/TreeName.set_position(Vector2(1400, text_start))
	$TreeStats/TreeName.add_font_override("font",dynamic_font)
	$TreeStats/TreeName.hide()
	$TreeStats/TreeHealth.set_position(Vector2(1310, text_start + v_gap))
	$TreeStats/TreeHealth.add_font_override("font",dynamic_font)
	$TreeStats/TreeHealth.hide()
	$TreeStats/TreeWaterStatus.set_position(Vector2(1310, text_start + 2 * v_gap))
	$TreeStats/TreeWaterStatus.add_font_override("font",dynamic_font)
	$TreeStats/TreeWaterStatus.hide()
	$TreeStats/TreeSpecialProperties.set_position(Vector2(1310, text_start + 3 * v_gap))
	$TreeStats/TreeSpecialProperties.add_font_override("font",dynamic_font)
	$TreeStats/TreeSpecialProperties.hide()
	$TreeStats/TreeMaturityStatus.set_position(Vector2(1310, text_start + 4 * v_gap))
	$TreeStats/TreeMaturityStatus.add_font_override("font",dynamic_font)
	$TreeStats/TreeMaturityStatus.hide()
	$TreeStats/TreeDeathStatus.set_position(Vector2(1310, text_start + 5 * v_gap))
	$TreeStats/TreeDeathStatus.add_font_override("font",dynamic_font)
	$TreeStats/TreeDeathStatus.hide()
	$TreeStats/TreeSunlight.set_position(Vector2(1310, text_start + 6 * v_gap))
	$TreeStats/TreeSunlight.add_font_override("font",dynamic_font)
	$TreeStats/TreeSunlight.hide()
	#sets the time that the tree was planted to be the current time
	time_planted = OS.get_unix_time()
	#setting health UI
	$TreeStats/HealthBar.set_position(Vector2(1400,370))
	$TreeStats/HealthBar/HealthBar.max_value = MAX_HEALTH
	$TreeStats/HealthBar/HealthBar.value = health
	$TreeStats/HealthBar.hide()
	#setting water UI
	$TreeStats/WaterIndicator.set_position(Vector2(1300,370))
	$TreeStats/WaterIndicator.hide()
	$TreeStats/SunlightIndicator.set_position(Vector2(1500,370))
	$TreeStats/SunlightIndicator.hide()
	
	


func _process(delta):
	if (not dead):
		set_special_property()
		adjust_growth_time()
		check_water_status()
		check_growth_status()
	check_death_status()
	_update_stats()
	
func set_special_property():
	if treeName == "snoop":
		special_property = "Sunlight"
	elif treeName == "water":
		special_property = "Water"
	else:
		special_property = "None"
"""
Adjusts the growth time based on what the sunlight level of the tree is.
"""
func adjust_growth_time():
	time_until_grown = 20 / sunlight
"""
Checks to see whether enough time has passed in real life for plants to 
need water. If enough time has passed, deduct health.
"""
func check_water_status():
	if treeName == "water":
		time_passed_since_watering = 0
	else:
		time_passed_since_watering = (OS.get_unix_time() - last_watering_time) - int(PauseMenu.pauseTime)
	
	if 13 - (time_passed_since_watering) > 10:
		wetness = "Wet"
		#_update_stats()
	elif 13 - (time_passed_since_watering) <=10 and 13-(time_passed_since_watering)>= 0:
		wetness = "Will Dry In " + str(13 - (time_passed_since_watering))
		#_update_stats()
	else:
		wetness = "Dry"
	if (time_passed_since_watering >= TIME_UNTIL_DRY) :
		deduct_health(healthDeduction)

"""
Checks to see if enough time has passed for the tree to grow.
If enough time has passed, changes the texture of the tree.
"""
func check_growth_status():
	if (OS.get_unix_time() - time_planted - int(PauseMenu.pauseTime) >= time_until_grown):
		tree_maturity = "Mature"
		$AnimatedSprite.set_frame(1)
		
"""
Checks if the tree health is 0. If it is, change the appearance to a dead tree.
Also, set the tree death variable to true.
"""
func check_death_status():
	if (health == 0):
		$AnimatedSprite.animation = "dead"
		if (tree_maturity == "Mature"):
			$AnimatedSprite.set_frame(1)
		else:
			$AnimatedSprite.set_frame(0)
		dead = true
		$healthDeduction.stop()

func is_dead():
	return dead

"""
Starts the health deduction timer if it's not already started
"""
func deduct_health(healthDeduction):
	if $healthDeduction.time_left == 0 and not dead:
		$healthDeduction.start()

"""
When the water button is pressed, resets countdown clock for water and stops
the health deduction timer.
"""
func _water_tree():
	if not dead:
		last_watering_time = OS.get_unix_time()
		health = MAX_HEALTH;
		wetness = "Wet"
		#_update_stats()
		$healthDeduction.stop()

"""
A timer to deduct health every 5 seconds.
"""
func _on_healthDeduction_timeout():
	health -= 1
	#_update_stats()
	
func _show_stats():
	$TreeStats/TreeStatPanel.show()
	$TreeStats/TreeHealth.show()
	$TreeStats/TreeHealth.set_text("Health: " + str(health))
	$TreeStats/TreeName.show()
	$TreeStats/TreeName.set_text(treeName)
	$TreeStats/TreeWaterStatus.show()
	#$TreeStats/TreeWaterStatus.set_text("Water Status: Wet")
	$TreeStats/TreeSpecialProperties.show()
	$TreeStats/TreeMaturityStatus.show()
	$TreeStats/TreeDeathStatus.show()
	$TreeStats/TreeSunlight.show()
	$TreeStats/HealthBar.show()
	$TreeStats/WaterIndicator.show()
	#$TreeStats/TreeMaturityStatus.set_text("Maturity: " + tree_maturity)
	$TreeStats/SunlightIndicator.show()
	
	
func _hide_stats():
	$TreeStats/TreeStatPanel.hide()
	$TreeStats/TreeHealth.hide()
	$TreeStats/TreeName.hide()
	$TreeStats/TreeWaterStatus.hide()
	$TreeStats/TreeSpecialProperties.hide()
	$TreeStats/TreeMaturityStatus.hide()
	$TreeStats/TreeDeathStatus.hide()
	$TreeStats/TreeSunlight.hide()
	$TreeStats/HealthBar.hide()
	$TreeStats/WaterIndicator.hide()
	$TreeStats/SunlightIndicator.hide()

func _update_stats():
	$TreeStats/TreeSpecialProperties.set_text("Special Property: " + special_property)	
	$TreeStats/TreeHealth.set_text("Health: " + str(health))
	$TreeStats/TreeWaterStatus.set_text("Water Status: " + wetness)
	$TreeStats/TreeMaturityStatus.set_text("Maturity: " + tree_maturity)
	$TreeStats/TreeDeathStatus.set_text("Dead: " + str(dead))
	$TreeStats/TreeSunlight.set_text("Sunlight: " + str(sunlight))
	$TreeStats/HealthBar/HealthBar.value = health
	$TreeStats/SunlightIndicator/SunlightLevel.set_text(str(sunlight))
	#updates water icon depending on wetness of tree
	if (wetness == "Wet"):
		$TreeStats/WaterIndicator/WaterIndicator.texture = \
			load("res://Assets/HUD/wet_icon.png")
	elif (wetness == "Dry"):
		$TreeStats/WaterIndicator/WaterIndicator.texture = \
			load("res://Assets/HUD/dry_icon.png")

#choose tree you want to plant
func _choose_tree(type):
	match (type):
		"air_sapling":
			treeName = "air"
		"water_sapling":
			treeName = "water"
		"earth_sapling":
			treeName = "earth"
		"fire_sapling":
			treeName = "fire"
		"magma_sapling":
			treeName = "magma"
		"snoop_sapling":
			treeName = "snoop"
		"cotton_candy_sapling":
			treeName = "cottoncandy"
		"lightning_sapling":
			treeName = "lightning"
		"bunny_sapling":
			treeName = "bunny"
		"sand_sapling":
			treeName = "sand"
		"bubble_sapling":
			treeName = "bubble"
		"tree_sapling":
			treeName = "tree"
	$AnimatedSprite.animation = treeName
	$AnimatedSprite.set_frame(0)

#removes selected tree	
func _remove_tree():
	queue_free()
	
func _special_power():
	if treeName == "water":
		"""
		Water all the trees in the surrounding 3x3 grid.
		"""
		for x in range(tree_x_index-1, tree_x_index + 2):
			for y in range(tree_y_index-1, tree_y_index + 2):
				#print("x: " + str(x) + "y: " + str(y))
				emit_signal("_water_tree_from_tree", x, y)
