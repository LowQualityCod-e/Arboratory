extends Control

export (NodePath) var dropdown_path
onready var dropdown = get_node(dropdown_path) #Acquires the Dropdown Node in the Scene
onready var seedData = ImportData.seed_data #Imports the Seed Data Database
onready var Water = get_tree().get_root().find_node("water", true, false) #Imports the water node from planting to here
var key = 0 #Creates the key variable and sets it to 1
var tempKey #Creates a temporary key used in the next and back buttons

func _ready():
	#load_tree() # Runs tree function for start
	dropdown.connect("item_selected", self, "on_item_selected") #Makes the tree change on dropdown editing
	add_items() #Adds the options to the dropdown menu on ready.
	disable_items() #Calls the disable function
	#dropdown.set_item_disabled(0,false)
	dropdown.set_item_text(0, "Choose your Tree") #Changes the Template Text to something else
	Water.connect("unlocked",self,"unlock") #Connects the unlocked signal from water to the unlock function

# Function to add items into the dropdown menu
func add_items():
	for lock in seedData:
		dropdown.add_item(seedData[str(lock)]["treeName"])

#Disables all tree options
func disable_items():
	for item in seedData:
		dropdown.set_item_disabled(int(item), true)

#Unlocks the tree once it is planted
func unlock(id):
	print ("Signal Recieved")
	dropdown.set_item_disabled(int(id), false)
	Leveling.gain_xp(5)

#Changes the Dex to represent the item selected
func on_item_selected(id):
	key = id
	if key != 0:
		load_tree()

#Closes the Dex and unpauses the main game
func _on_exit_button_pressed():
	get_tree().get_root().find_node("FarmButton",true,false).show()
	get_tree().get_root().find_node("treeDex_button",true,false).show()
	self.visible = false
	get_tree().paused = false
	get_tree().call_group("seedGroup","show")

#General Back Button function
func _on_back_button_pressed():
	tempKey = key #seperates the key value so it is preserved if everything else is disabled.
	if(tempKey <= 1):
		pass
	else:
		tempKey -= 1
	#Tells the back button if the next id is disabled or not and to skip if is
	for n in range(0,tempKey):
		print(n)
		if !(tempKey <= 0): 
			if dropdown.is_item_disabled(tempKey):
				tempKey -= 1
			else:
				dropdown.select(tempKey)
				key = tempKey
				load_tree()
				return

#General Next Button function
func _on_next_button_pressed():
	tempKey = key #seperates the key value so it is preserved if everything else is disabled.
	if(tempKey == seedData.size()):
		pass
	else:
		tempKey += 1
	#Tells the next button if the next id is disabled or not and to skip if is
	print(seedData.size())
	for n in range(tempKey,seedData.size()):
		print(n)
		print(tempKey)
		if dropdown.is_item_disabled(tempKey):
			tempKey += 1
		else:
			dropdown.select(tempKey)
			key = tempKey
			load_tree()
			return

#Generic loading tree function
func load_tree():
	$tree_id.text = str(key)
	$Tree_Art.texture = load(seedData[str(key)]["saplingImage"])
	$tree_name.text = seedData[str(key)]["treeName"]
	$tree_description.text = seedData[str(key)]["Description"]
	$tree_properties.text = "Coming Soon"
