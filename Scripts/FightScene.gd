extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player
var xpgain
var gpgain

# Called when the node enters the scene tree for the first time.
func _ready():
	player = self.get_parent().get_parent().get_parent().get_parent()
	xpgain = 10
	gpgain = 2
	if(player.tedhp==0):
		player.healchar(1,"Ted")
	if(player.maddyhp==0):
		player.healchar(1,"Maddy")
	self.get_node("Heroes/Maddy/RichTextLabel").set_text("Maddy HP"+str(player.maddyhp)+"/"+str(player.maddymaxhp))
	self.get_node("Heroes/Ted/RichTextLabel").set_text("Ted HP"+str(player.tedhp)+"/"+str(player.tedmaxhp))
	pass # Replace with function body.


#TEMP METHODS FOR TESTING BATTLE WIN AND LOSS STUFF


func _on_Win_pressed():
	player.addXP(xpgain)
	player.doTransaction(gpgain, true)
	Global.freeze=false
	if(player.tedhp==0):
		player.healchar(1,"Ted")
	if(player.maddyhp==0):
		player.healchar(1,"Maddy")
	self.queue_free()


func _on_Lose_pressed():
	player.incapacitated = true
	Global.freeze=false
	self.queue_free()
	

func _on_HurtMaddy_pressed():
	player.dealDamage(5, "Maddy")
	self.get_node("Heroes/Maddy/RichTextLabel").set_text("Maddy HP"+str(player.maddyhp)+"/"+str(player.maddymaxhp))
	self.get_node("Heroes/Ted/RichTextLabel").set_text("Ted HP"+str(player.tedhp)+"/"+str(player.tedmaxhp))
	if(player.maddyhp==0):
		self.get_node("Heroes/Maddy").visible=false
	if(player.incapacitated):
		Global.freeze=false
		self.queue_free()
	


func _on_HurtTed_pressed():
	player.dealDamage(5, "Ted")
	self.get_node("Heroes/Maddy/RichTextLabel").set_text("Maddy HP"+str(player.maddyhp)+"/"+str(player.maddymaxhp))
	self.get_node("Heroes/Ted/RichTextLabel").set_text("Ted HP"+str(player.tedhp)+"/"+str(player.tedmaxhp))
	if(player.tedhp==0):
		self.get_node("Heroes/Ted").visible=false
	if(player.incapacitated):
		Global.freeze=false
		self.queue_free() # Replace with function body.
