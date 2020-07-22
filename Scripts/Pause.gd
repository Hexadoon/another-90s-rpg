extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = self.get_parent().get_parent().get_parent().get_parent()
	self.get_node("Stats/GP").add_text(str(player.gp))
	
	self.get_node("Stats/Maddy").set_text("Maddy HP: " + str(player.maddyhp)+"/"+str(player.maddymaxhp) +"\n")
	self.get_node("Stats/Maddy").add_text("Maddy MP: " + str(player.maddymp)+"/"+str(player.maddymaxmp)+"\n")
	self.get_node("Stats/Maddy").add_text("Maddy XP: " + str(player.maddyxp)+"\n")
	self.get_node("Stats/Maddy").add_text("Maddy STR: " + str(player.maddystr)+"\n")
	self.get_node("Stats/Maddy").add_text("Maddy DEF: " + str(player.maddydef))
	
	self.get_node("Stats/Ted").set_text("Ted HP: " + str(player.tedhp)+"/"+str(player.tedmaxhp)+"\n")
	self.get_node("Stats/Ted").add_text("Ted MP: " + str(player.tedmp)+"/"+str(player.tedmaxmp)+"\n")
	self.get_node("Stats/Ted").add_text("Ted XP: " + str(player.tedxp)+"\n")
	self.get_node("Stats/Ted").add_text("Ted STR: " + str(player.tedstr)+"\n")
	self.get_node("Stats/Ted").add_text("Ted DEF: " + str(player.teddef))
	
	self.get_node("Stats/Sam").set_text("Sam HP: " + str(player.samhp)+"/"+str(player.sammaxhp)+"\n")
	self.get_node("Stats/Sam").add_text("Sam MP: " + str(player.sammp)+"/"+str(player.sammaxmp)+"\n")
	self.get_node("Stats/Sam").add_text("Sam XP: " + str(player.samxp)+"\n")
	self.get_node("Stats/Sam").add_text("Sam STR: " + str(player.samstr)+"\n")
	self.get_node("Stats/Sam").add_text("Sam DEF: " + str(player.samdef))
	
	self.get_node("Stats/Rose").set_text("Rose HP: " + str(player.rosehp)+"/"+str(player.rosemaxhp)+"\n")
	self.get_node("Stats/Rose").add_text("Rose MP: " + str(player.rosemp)+"/"+str(player.rosemaxmp)+"\n")
	self.get_node("Stats/Rose").add_text("Rose XP: " + str(player.rosexp)+"\n")
	self.get_node("Stats/Rose").add_text("Rose STR: " + str(player.rosestr)+"\n")
	self.get_node("Stats/Rose").add_text("Rose DEF: " + str(player.rosedef))
	
	
	
	if(Global.samexist):
		self.get_node("Stats/Sam").visible=true
	if(Global.roseexist):
		self.get_node("Stats/Rose").visible=true
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
