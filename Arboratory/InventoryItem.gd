extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var tree_appearance 
onready var tree_number 
# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureRect.set_scale(Vector2(.25,.25))
	print("treenumber: "+ str(tree_number))
	if tree_number == 0:
		$TextureRect.texture = load("res://Assets/Plants/trees/air_tree.png")
		tree_appearance = "air_tree"
	elif tree_number == 1:
		$TextureRect.texture = load("res://Assets/Plants/trees/fire_tree.png")
		tree_appearance = "fire_tree"
	elif tree_number == 2:
		$TextureRect.texture = load("res://Assets/Plants/trees/earth_tree.png")
		tree_appearance = "earth_tree"
	elif tree_number == 3:
		$TextureRect.texture = load("res://Assets/Plants/trees/magma_tree.png")
		tree_appearance = "magma_tree"
	elif tree_number == 4:
		$TextureRect.texture = load("res://Assets/Plants/trees/snoop_dogg_tree.png")
		tree_appearance = "snoop_tree"
	else:
		$TextureRect.texture = load("res://Assets/Plants/trees/water_tree.png")
		tree_appearance = "water_tree"
	

 
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
