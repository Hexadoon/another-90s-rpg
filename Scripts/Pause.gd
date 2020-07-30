extends Node2D


var player

# Called when the node enters the scene tree for the first time.
func _ready():
	player = self.get_parent().get_parent().get_parent().get_parent()
	self.get_node("Stats/GP").add_text(str(player.gp))
	
	self.get_node("Stats/Maddy").set_text("Maddy Lvl "+str(player.maddylvl)+"\n")
	self.get_node("Stats/Maddy").add_text("Maddy HP: " + str(player.maddyhp)+"/"+str(player.maddymaxhp) +"\n")
	self.get_node("Stats/Maddy").add_text("Maddy MP: " + str(player.maddymp)+"/"+str(player.maddymaxmp)+"\n")
	self.get_node("Stats/Maddy").add_text("Maddy XP: " + str(player.maddyxp)+"/"+str(player.maddynxtlvl)+"\n")
	self.get_node("Stats/Maddy").add_text("Maddy STR: " + str(player.maddystr)+"\n")
	self.get_node("Stats/Maddy").add_text("Maddy DEF: " + str(player.maddydef))
	
	self.get_node("Stats/Ted").set_text("Ted Lvl "+str(player.tedlvl)+"\n")
	self.get_node("Stats/Ted").add_text("Ted HP: " + str(player.tedhp)+"/"+str(player.tedmaxhp)+"\n")
	self.get_node("Stats/Ted").add_text("Ted MP: " + str(player.tedmp)+"/"+str(player.tedmaxmp)+"\n")
	self.get_node("Stats/Ted").add_text("Ted XP: " + str(player.tedxp)+"/"+str(player.tednxtlvl)+"\n")
	self.get_node("Stats/Ted").add_text("Ted STR: " + str(player.tedstr)+"\n")
	self.get_node("Stats/Ted").add_text("Ted DEF: " + str(player.teddef))
	
	self.get_node("Stats/Sam").set_text("Sam Lvl "+str(player.samlvl)+"\n")
	self.get_node("Stats/Sam").add_text("Sam HP: " + str(player.samhp)+"/"+str(player.sammaxhp)+"\n")
	self.get_node("Stats/Sam").add_text("Sam MP: " + str(player.sammp)+"/"+str(player.sammaxmp)+"\n")
	self.get_node("Stats/Sam").add_text("Sam XP: " + str(player.samxp)+"/"+str(player.samnxtlvl)+"\n")
	self.get_node("Stats/Sam").add_text("Sam STR: " + str(player.samstr)+"\n")
	self.get_node("Stats/Sam").add_text("Sam DEF: " + str(player.samdef))
	
	self.get_node("Stats/Rose").set_text("Rose Lvl "+str(player.roselvl)+"\n")
	self.get_node("Stats/Rose").add_text("Rose HP: " + str(player.rosehp)+"/"+str(player.rosemaxhp)+"\n")
	self.get_node("Stats/Rose").add_text("Rose MP: " + str(player.rosemp)+"/"+str(player.rosemaxmp)+"\n")
	self.get_node("Stats/Rose").add_text("Rose XP: " + str(player.rosexp)+"/"+str(player.rosenxtlvl)+"\n")
	self.get_node("Stats/Rose").add_text("Rose STR: " + str(player.rosestr)+"\n")
	self.get_node("Stats/Rose").add_text("Rose DEF: " + str(player.rosedef))
	
	
	
	if(Global.samexist):
		self.get_node("Stats/Sam").visible=true
		self.get_node("Stats/SamLead").visible=true
	if(Global.roseexist):
		self.get_node("Stats/Rose").visible=true
		self.get_node("Stats/RoseLead").visible=true



func _on_MaddyLead_pressed():
	player.changeLeader("Maddy")


func _on_TedLead_pressed():
	player.changeLeader("Ted")


func _on_SamLead_pressed():
	player.changeLeader("Sam")


func _on_RoseLead_pressed():
	player.changeLeader("Rose")
