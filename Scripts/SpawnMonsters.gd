extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var position 
var timestart
var timenow

# Called when the node enters the scene tree for the first time.
func _ready():
	position = self.get_node("Monster").position
	timestart=OS.get_unix_time() 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(not Global.freeze):
		timenow = OS.get_unix_time()
		var elapsed = (timenow-timestart) % 60
		if (elapsed == 5):
			timestart=OS.get_unix_time()
			var rand = randi()%5+1
			if rand == 1 and self.get_child_count() == 0:
				var scene = preload("res://Scenes/Monster.tscn")
				var node = scene.instance()
				self.add_child(node)
				node.position = position
			elif (rand==1 and self.get_child_count()==1):
				self.get_node("Monster/Sprite").play("popup")
	else:
		timestart=OS.get_unix_time()
