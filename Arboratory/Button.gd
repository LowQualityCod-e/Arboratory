extends Button

var index = 0
var labels = ["Nope, I just wanted to talk to you!",
"Really? So can I call you mine?", 
"Easy! When I ask you out, you say yes"]
#onready var button = get_node("Button")

# Called when the node enters the scene tree for the first time.
func _ready():
	hide() # Replace with function body.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_Button_pressed():
	waiting = false
	hide()

var waiting = false

func _on_RichTextLabel_releaseTheButtons(duration, numButtons, good):
	waiting = false
	print("numButtons: " + str(numButtons))
	if numButtons >= 2 or (numButtons == 1 and good):
		show() 
		if duration > 0 and index < labels.size() and !waiting:
			self.text = labels[index]
			index += 1
			duration -= 1
			waiting = true
	
func _toggled(_button_pressed):
	hide()


func _on_angry_byeButtons():
	queue_free() # Replace with function body.
	


func _on_Happy_byeButtons():
	queue_free() # Replace with function body.


func _on_RichTextLabel_hideButtons():
	hide() # Replace with function body.
