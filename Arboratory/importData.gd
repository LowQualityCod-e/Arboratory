extends Node

var seed_data
#var level_data

func _ready():
	var seedData_file = File.new()
	seedData_file.open("res://Data/Encyclotreedia.json", File.READ)
	var seedData_json = JSON.parse(seedData_file.get_as_text())
	seedData_file.close()
	seed_data = seedData_json.result
	for key in seed_data:
		seed_data[str(key)]["seedImage"] = load(seed_data[str(key)]["seedImage"])
	
	#var levelData_file = File.new()
	#levelData_file.open("res://Data/LevelEvents.json", File.READ)
	#var levelData_json = JSON.parse(levelData_file.get_as_test())
	#levelData_file.close()
	#level_data = levelData_json.result
