extends RayCast2D



var processing = false
var pausescreen = false
var camera

# Called when the node enters the scene tree for the first time.
func _ready():
	camera = self.get_parent().get_node("Display")
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
				var text = self.get_parent().get_node("Display/CanvasLayer/TextBox/TextBoxText")
				var texture = preload("res://Assets/Sam/sam_overworld_idle_down.png")
				self.get_collider().get_node("Sprite").set_texture(texture)
				self.get_parent().get_node("Display/CanvasLayer/TextBox").visible=true
				self.get_parent().get_node("Display/CanvasLayer/TextBox/TextBoxText").set_text("Madeline: Sam! There you are!")
				var t = Timer.new() #time spent being invulnerable
				t.set_wait_time(text.text.length()/20)
				t.set_one_shot(true)
				self.add_child(t)
				t.start()
				yield(t, "timeout")
				self.get_parent().get_node("Display/CanvasLayer/TextBox/TextBoxText").set_text("Sam: Have you seen my Magnemite card? I think I dropped it when I was looking for my De-Spell card...")
				t.set_wait_time(text.text.length()/20)
				t.start()
				yield(t, "timeout")
				self.get_parent().get_node("Display/CanvasLayer/TextBox/TextBoxText").set_text("Madeline: Sam, you can't go running off into the woods alone to look for a card! You could get yourself killed!")
				t.set_wait_time(text.text.length()/20)
				t.start()
				yield(t, "timeout")
				self.get_parent().get_node("Display/CanvasLayer/TextBox/TextBoxText").set_text("Sam Joined the Party!")
				t.set_wait_time(text.text.length()/20)
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
					var text = self.get_parent().get_node("Display/CanvasLayer/TextBox/TextBoxText")
					self.get_parent().get_node("Display/CanvasLayer/TextBox").visible=true
					text.set_text("Rose: Heh, did you think I was a mushroom before?")
					var t = Timer.new() #time spent being invulnerable
					t.set_wait_time(text.text.length()/20)
					t.set_one_shot(true)
					self.add_child(t)
					t.start()
					yield(t, "timeout")
					self.get_parent().get_node("Display/CanvasLayer/TextBox/TextBoxText").set_text("Madeline: You were a very convincing mushroom")
					t.set_wait_time(text.text.length()/20)
					t.start()
					yield(t, "timeout")
					self.get_parent().get_node("Display/CanvasLayer/TextBox/TextBoxText").set_text("Rose: Think I could trick real monsters with my ninja skills?")
					t.set_wait_time(text.text.length()/20)
					t.start()
					yield(t, "timeout")
					self.get_parent().get_node("Display/CanvasLayer/TextBox/TextBoxText").set_text("Madeline: If you're going to try, be careful, okay?")
					t.set_wait_time(text.text.length()/20)
					t.start()
					yield(t, "timeout")
					self.get_parent().get_node("Display/CanvasLayer/TextBox/TextBoxText").set_text("Rose Joined the Party!")
					t.set_wait_time(text.text.length()/20)
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
			camera.limit_bottom=1998
			camera.limit_left=251
			camera.limit_right=1294
			camera.limit_top=-112
		elif(self.get_collider().name=="Townpath"):
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
			camera.limit_bottom=1200
			camera.limit_left=-1330
			camera.limit_right=4280
			camera.limit_top=31
			
		processing = false
