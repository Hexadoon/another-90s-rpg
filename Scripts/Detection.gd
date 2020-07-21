extends RayCast2D



var processing = false
var pausescreen = false

# Called when the node enters the scene tree for the first time.
func _ready():
	set_enabled(true)
	pass # Replace with function body.


func _input(event):
	if(event is InputEventKey and event.pressed and not Global.freeze):
		if(Input.is_key_pressed(KEY_SPACE) and self.is_colliding()):
			if(self.get_collider().get_parent().name=="Inn"):
				var scene = preload("res://Scenes/InnDisplay.tscn")
				var node = scene.instance()
				self.get_parent().get_node("Display/CanvasLayer/Overlay").add_child(node)
				Global.freeze = true
	if(event is InputEventKey and event.pressed):
		if(Input.is_key_pressed(KEY_ESCAPE)):
			if not Global.freeze and not pausescreen:
				Global.freeze = true
				pausescreen=true
				var scene = preload("res://Scenes/Pause.tscn")
				var node = scene.instance()
				self.get_parent().get_node("Display/CanvasLayer/Overlay").add_child(node)
			elif Global.freeze and pausescreen:
				Global.freeze=false
				pausescreen=false
				self.get_parent().get_node("Display/CanvasLayer/Overlay/Pause").queue_free()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (self.is_colliding() and not processing and not Global.freeze):
		processing=true
		if(self.get_collider().get_parent().name=="Damage"):
			self.get_parent().overworld_damage(2)
			var t = Timer.new() #time spent being invulnerable
			t.set_wait_time(0.2)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
		elif(self.get_collider().get_parent().get_parent().name=="Monsters"):
			Global.freeze=true
			self.get_collider().queue_free()
			var scene = preload("res://Scenes/Fight.tscn")
			var node = scene.instance()
			self.get_parent().get_node("Display/CanvasLayer/Overlay").add_child(node)
			Global.freeze = true

		processing = false
