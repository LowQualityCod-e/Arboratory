extends Node2D
onready var farm = get_parent()
var soil_pos_x = 32
var soil_pos_y = 32


func _ready():
	for x in range(8):
		for y in range(7):
			var soil = load("res://SoilPlot.tscn").instance()
			add_child(soil)
			#soil.hide()
			soil.add_to_group("soilPlots")
			soil.set_position(Vector2(soil_pos_x,soil_pos_y))
			soil_pos_y +=64
		soil_pos_x +=64
		soil_pos_y = 32
	
	

func _draw():
	var LINE_COLOR = Color(255, 255, 255)
	var LINE_WIDTH = 2
	

	for x in range(farm.farm_size.x + 1):
		var col_pos = x * farm.tile_size.x
		var limit = farm.farm_size.y * farm.tile_size.y
		draw_line(Vector2(col_pos, 0), Vector2(col_pos, limit), LINE_COLOR, LINE_WIDTH)
	for y in range(farm.farm_size.y + 1):
		var row_pos = y * farm.tile_size.y
		var limit = farm.farm_size.x * farm.tile_size.x
		draw_line(Vector2(0, row_pos), Vector2(limit, row_pos), LINE_COLOR, LINE_WIDTH)
		
	
	
