extends Button

var once = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var index = 0
var labels = ["Who are you?",
"What about chicken nugget?",
"Whatever you say, chicken nugget"]
#onready var button = get_node("Button2")


# Called when the node enters the scene tree for the first time.
func _ready():
	hide() # Replace with function body.

var waiting = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_RichTextLabel_releaseTheButtons(duration, numButtons, good):
	waiting = false
	if numButtons >= 2 or (numButtons == 1 and !good):
		show() 
		if duration > 0 and index < labels.size() and !waiting:
			self.text = labels[index]
			index += 1
			duration -= 1
			waiting = true
#	if !once:
#		show() # Replace with function body.
#		once = true
#	else:
#		hide()



func _on_angry_byeButtons():
	queue_free()
	
func _on_Happy_byeButtons():
	queue_free()


func _on_RichTextLabel_hideButtons():
	hide()
