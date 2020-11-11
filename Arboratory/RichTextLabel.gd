extends RichTextLabel

var dialogue = [
	"This is Arboratory",
	"We're making a lot of cool trees",
	"More filler text",
	"End"
]

var dialogue_index = 0
signal showSprite
signal hideSprite
var interactable = false

func select_dialogue():
	match Leveling.level:
		1:
			print('successfully did the thing')
			dialogue = ["insert tutorial dialogue here",
			"testing that it does the other thing"]
			emit_signal("showSprite")
		3:
			dialogue = ["insert item dialogue here"]
			emit_signal("showSprite")
		5:
			dialogue = ["insert dating tutorial dialogue here"]
			emit_signal("showSprite")
			interactable = true
		_:
			hide()
			emit_signal("hideSprite")

signal releaseTheButtons


func _ready():
	select_dialogue()
	set_bbcode(dialogue[dialogue_index])
	set_visible_characters(0)
	set_process_input(true)
	
	
func _input(event):
	if event.is_pressed() && (event is InputEventScreenTouch ||
							  event is InputEventMouseButton):
		if get_visible_characters() > get_total_character_count():
			if dialogue_index < dialogue.size() - 1:
				dialogue_index += 1
				set_bbcode(dialogue[dialogue_index])
				set_visible_characters(0)
			elif interactable:
				emit_signal("releaseTheButtons")
			else:
				emit_signal("hideSprite")
				hide()
		else: 
			set_visible_characters(get_total_character_count())
	

func _on_Timer_timeout():
	set_visible_characters(get_visible_characters() + 1)




func _on_Button_pressed():
	hide() # Replace with function body.


func _on_Button2_pressed():
	hide() # Replace with function body.
