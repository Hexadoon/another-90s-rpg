extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var textbox
var controlstext = "Controls:\n\nUse the ARROW KEYS to Move\n\nUse SPACEBAR to interact with NPCs\n\nUse ESCAPE to pause the game in the overworld and leave interfaces\n\nCLICK to select items in the Inn and see offers\n\nGet too close to an enemy and Combat will ensue!\n\n\n\nDuring combat:\n\nPress A with good timing to block an attack or deal extra damage\n\nCLICK on attack or special move during the player turn to choose what to do\n\nUse UP & DOWN ARROW KEYS to select a target"

var charstext="Characters:\n\nMadeline “Syringe” Gutierrez:\nMed student, obligatory cleric who has a “unique” style of healing. 90s college sorority girl style. Non med student hobbies: haha, hahahahahahahaha, oh you’re serious? Hahahahahaha.\nSpecial Attack, Syringe:\nMaddy uses her syringe to heal an ally a small amount\n\nTed “Big Bat” Michaels:\nBaseball player, a kind hearted tank who is no slouch on offense. He tries very hard to look cool, but how cool can you really look in a highschool baseball uniform?. Non sports hobbies: Viddy games, bottle cap collecting, and playing the drums.\nSpecial Attack, Major League Baseball Featuring Ken Griffey Jr: \nTed swings his bat with all his might dealing more damage than usual\n\nSam “Cardmaster” Rosen:\nTCG playing kid, smart spellcaster who has a quick wit to match. Wears clothes his mom picked out for him. Non card collecting hobbies: Bugs, watching cartoons.\nSpecial Attack, Magnemite Lv. 13:\nSam plays a card from his hand dealing low damage to all enemies\n\nRose “Silent Blade” Smith:\nThinks she’s a ninja, good at debuffs and attacking enemy weaknesses. Uses her ordinary clothes to make herself look as much like a ninja as possible. Non ninja hobbies: Plants, gymnastics.\nSpecial Attack, Pocket Sand:\nRose throws some sand from her pocket causing an enemy to lose a turn"
# Called when the node enters the scene tree for the first time.
func _ready():
	textbox=self.get_node("Instructions/RichTextLabel")
	textbox.set_text(controlstext)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Overworld.tscn")

func _on_Controls_pressed():
	textbox.set_text(controlstext)
	pass # Replace with function body.


func _on_Characters_pressed():
	textbox.set_text(charstext)
	pass # Replace with function body.
