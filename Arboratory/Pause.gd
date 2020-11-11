extends CanvasLayer
"""
Works by pausing the main tree itself. 
This means that every scene in the entire game is stopped.
If you would like to make sure a scene still works during paused state,
Change the pause mode to process
Taken from: https://www.youtube.com/watch?v=WaotOuDNio8
"""
var isPaused = false;
var pauseTime = 0
func _ready():
	set_visible(false)

func _process(delta):
	if isPaused:
		pauseTime = pauseTime + 1*delta;

func pauseGame():
	set_visible(!get_tree().paused)	
	isPaused = !get_tree().paused;
	get_tree().paused = !get_tree().paused


func _on_Continue_pressed():
	get_tree().paused = false;
	set_visible(false)
	isPaused = false
	
func set_visible(is_visible):
	for node in get_children():
		node.visible = is_visible
