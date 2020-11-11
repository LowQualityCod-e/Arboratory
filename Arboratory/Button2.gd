extends Button

var once = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	hide() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_RichTextLabel_releaseTheButtons():
	show()
#	if !once:
#		show() # Replace with function body.
#		once = true
#	else:
#		hide()





func _on_angry_byeButtons():
	queue_free()
	
func _on_Happy_byeButtons():
	queue_free()
