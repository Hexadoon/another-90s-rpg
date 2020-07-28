extends AudioStreamPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var setting
var isfight

# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_stream(preload("res://Game Ready Sounds/About Town.wav"))
	self.play()
	setting = "Town"
	isfight=false
	pass # Replace with function body.

func _process(delta):
	if(Global.setting == "Fight" and not isfight):
		isfight=true
		setmusic("Fight")
		Global.setting=setting
	elif(Global.setting=="NoFight" and isfight):
		isfight=false
		setmusic(setting)
	else:
		if(not Global.setting == setting):
			setting=Global.setting
			setmusic(setting)
		

func setmusic(setting):
	if(setting=="Town"):
		self.set_stream(preload("res://Game Ready Sounds/About Town.wav"))
		self.play()
	elif(setting=="Fight"):
		self.set_stream(preload("res://Game Ready Sounds/Fight Music.wav"))
		self.play()
	elif(setting=="Forest"):
		self.set_stream(preload("res://Game Ready Sounds/SpiritedForest.wav"))
		self.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
