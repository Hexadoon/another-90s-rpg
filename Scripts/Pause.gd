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
	self.get_node("Stats/Maddy").add_text("Maddy XP: " + str(player.maddyxp))
	
	self.get_node("Stats/Ted").set_text("Ted HP: " + str(player.tedhp)+"/"+str(player.tedmaxhp)+"\n")
	self.get_node("Stats/Ted").add_text("Ted MP: " + str(player.tedmp)+"/"+str(player.tedmaxmp)+"\n")
	self.get_node("Stats/Ted").add_text("Ted XP: " + str(player.tedxp))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
