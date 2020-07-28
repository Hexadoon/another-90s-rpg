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
			if(self.get_collider().name=="Sam"):
				Global.freeze=true
				Global.samexist=true
				self.get_parent().get_node("Display/CanvasLayer/TextBox").visible=true
				self.get_parent().get_node("Display/CanvasLayer/TextBox/TextBoxText").set_text("Madeline: Sam! There you are!")
				var t = Timer.new() #time spent being invulnerable
				t.set_wait_time(4)
				t.set_one_shot(true)
				self.add_child(t)
				t.start()
				yield(t, "timeout")
				self.get_parent().get_node("Display/CanvasLayer/TextBox/TextBoxText").set_text("Sam: Have you seen my Magnemite card? I think I dropped it when I was looking for my De-Spell card...")
				t.start()
				yield(t, "timeout")
				self.get_parent().get_node("Display/CanvasLayer/TextBox/TextBoxText").set_text("Madeline: Sam, you can't go running off into the woods alone to look for a card! You could get yourself killed!")
				t.start()
				yield(t, "timeout")
				self.get_parent().get_node("Display/CanvasLayer/TextBox/TextBoxText").set_text("Sam Joined the Party!")
				t.start()
				yield(t, "timeout")
				self.get_parent().get_node("Display/CanvasLayer/TextBox").visible=false
				self.get_collider().visible=false
				self.get_collider().position = Vector2(-1000,-1000)
				t.queue_free()
				self.get_collider().queue_free()
				Global.freeze=false
			if(self.get_collider().name=="Rose"):
				if(Global.samexist):
					Global.freeze=true
					Global.roseexist=true
					self.get_parent().get_node("Display/CanvasLayer/TextBox").visible=true
					self.get_parent().get_node("Display/CanvasLayer/TextBox/TextBoxText").set_text("Rose: Heh, did you think I was a mushroom before?")
					var t = Timer.new() #time spent being invulnerable
					t.set_wait_time(3)
					t.set_one_shot(true)
					self.add_child(t)
					t.start()
					yield(t, "timeout")
					self.get_parent().get_node("Display/CanvasLayer/TextBox/TextBoxText").set_text("Madeline: You were a very convincing mushroom")
					t.start()
					yield(t, "timeout")
					self.get_parent().get_node("Display/CanvasLayer/TextBox/TextBoxText").set_text("Rose: Think I could trick real monsters with my ninja skills?")
					t.start()
					yield(t, "timeout")
					self.get_parent().get_node("Display/CanvasLayer/TextBox/TextBoxText").set_text("Madeline: If you're going to try, be careful, okay?")
					t.start()
					yield(t, "timeout")
					self.get_parent().get_node("Display/CanvasLayer/TextBox/TextBoxText").set_text("Rose Joined the Party!")
					t.start()
					yield(t, "timeout")
					self.get_parent().get_node("Display/CanvasLayer/TextBox").visible=false
					self.get_collider().visible=false
					self.get_collider().position = Vector2(-1000,-1000)
					t.queue_free()
					self.get_collider().queue_free()
					Global.freeze=false
				else:
					self.get_collider().get_node("Sprite").play("popup")

			
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
			Global.setting="Fight"
			Global.freeze = true
		elif(self.get_collider().name=="Forestpath"):
			Global.setting="Forest"
			self.get_parent().get_parent().get_node("Background").get_child(0).queue_free()
			var scene = preload("res://Scenes/ForestBackground.tscn")
			var node = scene.instance()
			self.get_parent().get_parent().get_node("Background").add_child(node)
			self.get_parent().get_parent().get_node("Foreground").get_child(0).queue_free()
			scene = preload("res://Scenes/ForestForeground.tscn")
			node = scene.instance()
			self.get_parent().get_parent().get_node("Foreground").add_child(node)
			self.get_parent().position=Vector2(747,1900)
		elif(self.get_collider().name=="Townpath"):
			print(str(self.get_parent().position))
			Global.setting="Town"
			self.get_parent().get_parent().get_node("Background").get_child(0).queue_free()
			var scene = preload("res://Scenes/TownBackground.tscn")
			var node = scene.instance()
			self.get_parent().get_parent().get_node("Background").add_child(node)
			self.get_parent().get_parent().get_node("Foreground").get_child(0).queue_free()
			scene = preload("res://Scenes/TownForeground.tscn")
			node = scene.instance()
			self.get_parent().get_parent().get_node("Foreground").add_child(node)
			self.get_parent().position=Vector2(601,133)

		processing = false
