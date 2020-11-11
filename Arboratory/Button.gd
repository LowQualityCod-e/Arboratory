extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	hide() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_Button_pressed():
	show() # Replace with function body.



func _on_RichTextLabel_releaseTheButtons():
	show() # Replace with function body.
	
func _toggled(_button_pressed):
	hide()


func _on_angry_byeButtons():
	queue_free() # Replace with function body.
	



func _on_Happy_byeButtons():
	queue_free() # Replace with function body.
