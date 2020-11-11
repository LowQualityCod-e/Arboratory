extends RichTextLabel

var dialogue = [
	"!!",
	"Did I upset you?",
	"End"
]

var dialogue_index = 0
signal byeButtons
signal endSequence

func _ready():
	set_bbcode(dialogue[dialogue_index])
	set_visible_characters(0)
	set_process_input(true)
	hide()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
 # Replace with function body.
	
func _input(event):
	if event.is_pressed() && (event is InputEventScreenTouch ||
							  event is InputEventMouseButton):
		if get_visible_characters() > get_total_character_count():
			if dialogue_index < dialogue.size() - 1:
				dialogue_index += 1
				set_bbcode(dialogue[dialogue_index])
				set_visible_characters(0)
			else:
				emit_signal("endSequence")
				hide()
		else: 
			set_visible_characters(get_total_character_count())

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button2_pressed():
	show() # Replace with function body.
	emit_signal("byeButtons")




func _on_Timer3_timeout():
	set_visible_characters(get_visible_characters() + 1) # Replace with function body. # Replace with function body.
