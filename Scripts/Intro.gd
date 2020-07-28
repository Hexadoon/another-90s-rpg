extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.freeze=true
	var t = Timer.new()
	t.set_wait_time(1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	self.get_parent().get_node("MaddySprite").play("idleside")
	var text = self.get_parent().get_node("Display/CanvasLayer/TextBox/TextBoxText")		
	self.get_parent().get_node("Display/CanvasLayer/TextBox").visible=true
	text.set_text("Ted: Hi Maddy, is Eddy home?")
	t.set_wait_time(text.text.length()/15)
	t.start()
	yield(t, "timeout")
	text.set_text("Madeline: No.")
	t.set_wait_time(2)
	t.start()
	yield(t, "timeout")
	text.set_text("")
	t.set_wait_time(.7)
	t.start()
	yield(t, "timeout")
	self.get_parent().get_node("MaddySprite").play("idleup")
	t.set_wait_time(.7)
	t.start()
	yield(t, "timeout")
	self.get_parent().get_node("MaddySprite").play("idledown")
	t.set_wait_time(.7)
	t.start()
	yield(t, "timeout")
	self.get_parent().get_node("MaddySprite").flip_h=true
	self.get_parent().get_node("MaddySprite").play("idleside")
	t.set_wait_time(.7)
	t.start()
	yield(t, "timeout")
	self.get_parent().get_node("MaddySprite").flip_h=true
	text.set_text("Ted: ...")
	t.set_wait_time(2)
	t.start()
	yield(t, "timeout")
	self.get_parent().get_node("MaddySprite").flip_h=false
	text.set_text("Madeline: Have you seen Sam?")
	t.set_wait_time(text.text.length()/10)
	t.start()
	yield(t, "timeout")
	text.set_text("Ted: Mrs. Rosen's kid?")
	t.set_wait_time(text.text.length()/10)
	t.start()
	yield(t, "timeout")
	text.set_text("Madeline: Yeah. I was supposed to be babysitting him, but the brat ran off to hide, and I guess he must've left the house because I can't find him anywhere.")
	t.set_wait_time(text.text.length()/20)
	t.start()
	yield(t, "timeout")
	text.set_text("Madeline: Can you help me look for him? I'm afraid he might've wandered into the woods...")
	t.set_wait_time(text.text.length()/20)
	t.start()
	yield(t, "timeout")
	text.set_text("Ted: Sucks for you.")
	t.set_wait_time(text.text.length()/15)
	t.start()
	yield(t, "timeout")
	text.set_text("Madeline: I won't take the TV from you and Eddy when Friends comes on.")
	t.set_wait_time(text.text.length()/20)
	t.start()
	yield(t, "timeout")
	text.set_text("Ted: Deal.")
	t.set_wait_time(text.text.length()/15)
	t.start()
	yield(t, "timeout")
	text.set_text("Ted Joined the Party!")
	t.set_wait_time(text.text.length()/15)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	self.queue_free()
	Global.freeze=false
	self.get_parent().get_node("Display/CanvasLayer/TextBox").visible=false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
