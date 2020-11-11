extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var tree_appearance 
onready var tree_number 
onready var item_name
onready var tree_name
onready var item_number
# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureRect.set_scale(Vector2(.25,.25))
	
	if tree_number == "6":
		$TextureRect.texture = load("res://Assets/Plants/saplings/air_sapling.png")
		tree_appearance = "air_sapling"
		tree_name = "air"
	elif tree_number == "9":
		$TextureRect.texture = load("res://Assets/Plants/saplings/fire_sapling.png")
		tree_appearance = "fire_sapling"
		tree_name = "fire"
	elif tree_number == "8":
		$TextureRect.texture = load("res://Assets/Plants/saplings/earth_sapling.png")
		tree_appearance = "earth_sapling"
		tree_name = "earth"
	elif tree_number == "10":
		$TextureRect.texture = load("res://Assets/Plants/saplings/magma_sapling.png")
		tree_appearance = "magma_sapling"
		tree_name = "magma"
	elif tree_number == "11":
		$TextureRect.texture = load("res://Assets/Plants/saplings/snoop_dogg_sapling.png")
		tree_appearance = "snoop_sapling"
		tree_name = "snoop"
	elif tree_number == "12":
		$TextureRect.texture = load("res://Assets/Plants/saplings/water_sapling.png")
		tree_appearance = "water_sapling"
		tree_name = "water"
	elif tree_number == "7":
		$TextureRect.texture = load("res://Assets/Plants/saplings/cotton_candy_sapling.png")
		tree_appearance = "cotton_candy_sapling"
		tree_name = "cottoncandy"
	elif tree_number == "4":
		$TextureRect.texture = load("res://Assets/Plants/saplings/lightning_sapling.png")
		tree_appearance = "lightning_sapling"
		tree_name = "lightning"
	elif tree_number == "3":
		$TextureRect.texture = load("res://Assets/Plants/saplings/bunny_sapling.png")
		tree_appearance = "bunny_sapling"
		tree_name = "bunny"
	elif tree_number == "5":
		$TextureRect.texture = load("res://Assets/Plants/saplings/sand_sapling.png")
		tree_appearance = "sand_sapling"
		tree_name = "sand"
	elif tree_number == "13":
		$TextureRect.texture = load("res://Assets/Plants/saplings/bubble_sapling.png")
		tree_appearance = "bubble_sapling"
		tree_name = "bubble"
	elif tree_number == "14":
		$TextureRect.texture = load("res://Assets/Plants/saplings/tree_sapling.png")
		tree_appearance = "tree_sapling"
		tree_name = "tree"
	elif item_name == "water":
		$TextureRect.texture = load("res://Assets/Plants/seeds/water_seed.png")
		item_number = "12"
	elif item_name == "air":
		$TextureRect.texture = load("res://Assets/Plants/seeds/air_seed.png")
		item_number = "6"
	elif item_name == "earth":
		$TextureRect.texture = load("res://Assets/Plants/seeds/earth_seed.png")
		item_number = "8"
	elif item_name == "fire":
		$TextureRect.texture = load("res://Assets/Plants/seeds/fire_seed.png")
		item_number = "9"
	elif item_name == "magma":
		$TextureRect.texture = load("res://Assets/Plants/seeds/magma_seed.png")
		item_number = "10"
	elif item_name == "snoop":
		$TextureRect.texture = load("res://Assets/Plants/seeds/snoop_dogg_seed.png")
		item_number = "11"
	elif item_name == "cottoncandy":
		$TextureRect.texture = load("res://Assets/Plants/seeds/cotton_candy_seed.png")
		item_number = "7"
	elif item_name == "lightning":
		$TextureRect.texture = load("res://Assets/Plants/seeds/lightning_seed.png")
		item_number = "4"
	elif item_name == "bunny":
		$TextureRect.texture = load("res://Assets/Plants/seeds/bunny_seed.png")
		item_number = "3"
	elif item_name == "sand":
		$TextureRect.texture = load("res://Assets/Plants/seeds/sand_seed.png")
		item_number = "5"
	elif item_name == "bubble":
		$TextureRect.texture = load("res://Assets/Plants/seeds/bubble_seed.png")
		item_number = "13"
	elif item_name == "tree":
		$TextureRect.texture = load("res://Assets/Plants/seeds/tree_seed.png")
		item_number = "14"
	

 
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
