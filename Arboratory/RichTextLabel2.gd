extends RichTextLabel

var diaStat = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_bbcode("Love feelings: " + str(diaStat)) # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Happy_goodChoice():
	diaStat = diaStat + 1
	set_bbcode("Love feelings: " + str(diaStat))
	
