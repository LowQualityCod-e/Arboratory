#Dialogue.gd
extends RichTextLabel

var dialogue = [
	"This is Arboratory",
	"We're making a lot of cool trees",
	"More filler text",
	"End"
]

var dialogue_index = 0

func _ready():
	print('ready')
	select_dialogue()
	print("should've done the thing")
	set_bbcode(dialogue[dialogue_index])
	set_visible_characters(0)
	set_process_input(true)
	
func select_dialogue():
	match Leveling.level:
		1:
			print('successfully did the thing')
			dialogue = ["insert tutorial dialogue here"]
		3:
			dialogue = ["insert item dialogue here"]
		5:
			dialogue = ["insert dating tutorial dialogue here"]

func _input(event):
	if event.is_pressed() && (event is InputEventScreenTouch ||
							  event is InputEventMouseButton):
		if get_visible_characters() > get_total_character_count():
			if dialogue_index < dialogue.size() - 1:
				dialogue_index += 1
				set_bbcode(dialogue[dialogue_index])
				set_visible_characters(0)
		else: 
			set_visible_characters(get_total_character_count())
	

func _on_Timer_timeout():
	set_visible_characters(get_visible_characters() + 1)
