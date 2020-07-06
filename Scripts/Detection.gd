extends RayCast2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var processing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	set_enabled(true)
	pass # Replace with function body.


func _input(event):
	if(Input.is_key_pressed(KEY_SPACE) and self.is_colliding()):
		if(self.get_collider().name=="Heal2"):
			self.get_parent().resetHealth()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (self.is_colliding() and not processing):
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

		
		processing = false
