extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var player
var transaction = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	player = self.get_parent().get_parent().get_parent().get_parent()
	pass # Replace with function body.

func _input(event):
	if(event is InputEventKey and event.pressed):
		if(Input.is_key_pressed(KEY_ESCAPE)):
			transaction = -1
			leave()

func leave():
	Global.freeze = false
	if transaction == 0:
		player.doTransaction(10, false)
		player.heal(player.maxhp/2)
	if transaction == 1:
		player.doTransaction(20, false)
		player.resetHealth()
	self.queue_free()


func _on_ShortRest_pressed(): #0
	transaction =0
	self.get_node("Textbox").set_text("A short nap? That'll be 10 gold")
	self.get_node("Yesno").visible = true

func _on_RestButton_pressed(): #1
	transaction =1
	self.get_node("Textbox").set_text("Spend the night? That'll be 20 gold")
	self.get_node("Yesno").visible = true

func _on_Yes_pressed():
	self.get_node("Yesno").visible = false
	leave()

func _on_No_pressed():
	transaction =-1
	self.get_node("Yesno").visible = false
	self.get_node("Textbox").set_text("Maybe next time then.") # Replace with function body.
