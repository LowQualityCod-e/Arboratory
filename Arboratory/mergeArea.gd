extends Area2D

onready var Water = get_tree().get_root().find_node("water", true, false)#Declares variables as instances of Nodes in the Scene
onready var Seeds = get_tree().get_root().find_node("Seeds", true, false).get_children()
var seeded = false
var planted = 0
var whichSeed
signal seeded


#Sets all the connected nodes up

func _ready():
	Water.connect("watered",self,"grow") #Tells Godot that these nodes will emit a certain signal and to run a function when it does
	for Seed in Seeds:
		Seed.connect("planted",self,"planted")
	

"""
When the seed is overlaps with the pot it will emit a planted signal activating the planted function over here.
The signal is also emitted when the seed leaves the pot.
The function itself will switch the local variable seeded to true and false based on how many times the function has been called
The print line Planted Function was run is for debugging
"""

func planted(theSeed):
	whichSeed = theSeed
	if planted % 2 == 0:
		seeded = true
	else:
		seeded = false
	planted += 1
	



"""
When the water overlaps with the pot it will emit a signal "watered" which activates the grow function.
The function itself will emit a signal "seeded" that will be used in a different script.
The print line we made it this far is just for debugging.
"""

func grow():
	if seeded:
		emit_signal("seeded", whichSeed)
		


