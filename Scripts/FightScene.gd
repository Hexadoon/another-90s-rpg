extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player
var xpgain
var gpgain
var hp = [10, 10, 10]
var monstertype
var nummonsters

var playerturn = true

# Called when the node enters the scene tree for the first time.
func _ready():
	player = self.get_parent().get_parent().get_parent().get_parent()
	monstertype = 0 #TEMP SETTING
	setupMonsters(monstertype)
	
	if(player.tedhp==0):
		player.healchar(1,"Ted")
	if(player.maddyhp==0):
		player.healchar(1,"Maddy")
	self.get_node("Heroes/Maddy/RichTextLabel").set_text("Maddy HP"+str(player.maddyhp)+"MP"+str(player.maddymp))
	self.get_node("Heroes/Ted/RichTextLabel").set_text("Ted HP"+str(player.tedhp)+"MP"+str(player.tedmp))

func setupMonsters(type):
	#TEMP METHOD, important for when we have more than 1 type of monster
	xpgain = 10
	gpgain = 2
	nummonsters = 3
	self.get_node("Enemies/Monster/RichTextLabel").set_text("HP"+str(hp[0]))
	self.get_node("Enemies/Monster2/RichTextLabel").set_text("HP"+str(hp[1]))
	self.get_node("Enemies/Monster3/RichTextLabel").set_text("HP"+str(hp[2]))	



func enemyattack(target):
	var rand = randi()%100+1
	if(rand<20):
		self.get_node("RichTextLabel").set_text("MISS")
	elif(rand<95):
		doDamageEffect(target, false)
		player.dealDamage(5, target)
		self.get_node("RichTextLabel").set_text("HIT")
	elif(rand>=95):
		doDamageEffect(target, false)
		self.get_node("RichTextLabel").set_text("CRITICAL HIT")
		player.dealDamage(10,target)
		
	#post damage checkups (did anyone die? Is the battle done? Set the hp markers)
	if(player.maddyhp==0):
		self.get_node("Heroes/Maddy").visible=false
	if(player.tedhp==0):
		self.get_node("Heroes/Ted").visible=false
	if(player.incapacitated):
		self.queue_free()
		Global.unfreeze()
	self.get_node("Heroes/Maddy/RichTextLabel").set_text("Maddy HP"+str(player.maddyhp)+"MP"+str(player.maddymp))
	self.get_node("Heroes/Ted/RichTextLabel").set_text("Ted HP"+str(player.tedhp)+"MP"+str(player.tedmp))
	
func playerattack(target):
	var rand = randi()%100+1
	if(rand<20):
		self.get_node("RichTextLabel").set_text("MISS")
	elif(rand<95):
		doDamageEffect(target, true)
		self.get_node("RichTextLabel").set_text("HIT")
		hp[target-1]-=5
	else:
		doDamageEffect(target, true)
		self.get_node("RichTextLabel").set_text("CRITICAL HIT")
		hp[target-1]-=10
	if(hp[target-1]<=0):
		if(target==1):
			self.get_node("Enemies/Monster").visible = false
		elif(target==2):
			self.get_node("Enemies/Monster2").visible = false
		elif(target==3):
			self.get_node("Enemies/Monster3").visible = false
		nummonsters-=1
		if(nummonsters<=0):
			_on_Win_pressed()
	self.get_node("Enemies/Monster/RichTextLabel").set_text("HP"+str(hp[0]))
	self.get_node("Enemies/Monster2/RichTextLabel").set_text("HP"+str(hp[1]))
	self.get_node("Enemies/Monster3/RichTextLabel").set_text("HP"+str(hp[2]))	

	
func doDamageEffect(target, type):
	#type is true for monsters and false for heroes
	var node
	self.get_node("TEMP").visible=false
	if(type):
		if(target==1):
			node = self.get_node("Enemies/Monster")
		elif(target==2):
			node = self.get_node("Enemies/Monster2")
		elif(target==3):
			node=self.get_node("Enemies/Monster3")
	else:
		if(target=="Ted"):
			node=self.get_node("Heroes/Ted")
		elif(target=="Maddy"):
			node=self.get_node("Heroes/Maddy")
	node.modulate.a = 0.5
	var t = Timer.new() #time spent being invulnerable
	t.set_wait_time(0.2)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	node.modulate.a = 1
	t.queue_free()
	self.get_node("TEMP").visible=true

func playerspecial(user, target):
	if(player.useMP(5, user)):
		if(user=="Ted"):
			self.get_node("RichTextLabel").set_text("Ted Goes All Out!")
			playerattack(target)
			playerattack(target)
			playerattack(target)
			playerattack(target)
			playerattack(target)
		if(user=="Maddy"):
			self.get_node("RichTextLabel").set_text("Maddy heals"+ target)
			player.healchar(5, target)
			self.get_node("Heroes/Maddy/RichTextLabel").set_text("Maddy HP"+str(player.maddyhp)+"MP"+str(player.maddymp))
			self.get_node("Heroes/Ted/RichTextLabel").set_text("Ted HP"+str(player.tedhp)+"MP"+str(player.tedmp))
	else:
		self.get_node("RichTextLabel").set_text("OUT OF MP")

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

func getMonster() -> int:
	var rand = randi()%3
	while(hp[rand]<=0):
		rand = randi()%3
	rand+=1
	return rand
	

func randomHero() -> String:
	if(self.get_node("Heroes/Maddy").visible and self.get_node("Heroes/Ted").visible):
		var rand = randi()%2+1
		if(rand==1):
			return "Ted"
		else:
			return "Maddy"
	elif(self.get_node("Heroes/Maddy").visible):
		return "Maddy"
	else:
		return "Ted"

func _on_PlayerAttack_pressed():
	var target = getMonster()
	playerattack(target)


func _on_PlayerSpecial_pressed():
	var user = randomHero()
	var target
	if(user=="Maddy"):
		target = randomHero()
	else:
		target = getMonster()
	playerspecial(user, target)


func _on_MonsterAttack_pressed():
	var target = randomHero()
	enemyattack(target)
	pass # Replace with function body.
