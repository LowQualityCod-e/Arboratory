extends Node

export (int) var level = 1

var experience = 0
var required_experience = get_next_level_xp(level)

onready var progress_bar = $PlantingNotifier/ProgressBar/One/Two/Three/Progress
onready var progress_level = $PlantingNotifier/ProgressBar/One/Two/Three/Words/Background/LevelText

#increases the total amount of xp you have
#levels up if the experience total meets the amount of experience needed
func gain_xp(value):
	print('xp gained!')
	var mult = value * level
	experience += mult
	if (experience >= required_experience):
		experience -= required_experience;
		gain_level()

#increases level by 1
func gain_level():
	print('level up!')
	level += 1
	required_experience = get_next_level_xp(level)
	if level == 3:
		get_tree().get_root().find_node("Planting",true,false)._new_merge_item("carrot")
		get_tree().get_root().find_node("Planting",true,false)._new_merge_item("unidentified_grass")
		get_tree().get_root().find_node("Planting",true,false)._new_merge_item("candy")
		get_tree().get_root().find_node("Planting",true,false)._new_merge_item("lavender")
		get_tree().get_root().find_node("Planting",true,false)._new_merge_item("rock")
		for member in get_tree().get_nodes_in_group("seedGroup"):
			member.set_position(member.seed_pos)
		get_tree().get_root().find_node("RichTextLabel",true,false).dialogue_index = 0
		get_tree().get_root().find_node("RichTextLabel",true,false)._ready()
	if level == 5:
		for member in get_tree().get_nodes_in_group("seedGroup"):
			member.set_position(member.seed_pos)
		get_tree().get_root().find_node("RichTextLabel",true,false).dialogue_index = 0
		get_tree().get_root().find_node("RichTextLabel",true,false)._ready()

#returns the xp needed to get to the next level
func get_next_level_xp(level_num):
	return 30 * level_num
	#return 10 * level_num
	
	
#getters
func get_level():
	return level
	
func get_experience():
	return experience
	
func get_required_experience():
	return required_experience
