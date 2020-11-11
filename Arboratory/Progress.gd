extends TextureProgress



# Called when the node enters the scene tree for the first time.
func _ready():
	self.value = Leveling.get_experience()
	self.max_value = Leveling.get_required_experience()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.value = Leveling.get_experience()
	self.max_value = Leveling.get_required_experience()
