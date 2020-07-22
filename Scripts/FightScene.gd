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
var endattack
var turn
var numturns
var monstr
var mondef
var mondmg
#MONSTER STATS SET DURING SETUPMONSTERS

var playerturn = false
var playerdone
var done

# Called when the node enters the scene tree for the first time.
func _ready():
	player = self.get_parent().get_parent().get_parent().get_parent()
	monstertype = 0 #TEMP SETTING
	setupMonsters(monstertype)
	numturns=4
	if(Global.roseexist):
		self.get_node("Heroes/Rose").visible=true
		if(player.rosehp==0):
			player.healchar(1,"Rose")
		numturns+=1
	if(Global.samexist):
		self.get_node("Heroes/Sam").visible=true
		if(player.samhp==0):
			player.healchar(1,"Sam")
		numturns+=1
	turn = randi()%numturns
	done=true
	playerdone=true
	if(player.tedhp==0):
		player.healchar(1,"Ted")
	if(player.maddyhp==0):
		player.healchar(1,"Maddy")
	self.get_node("Heroes/Maddy/RichTextLabel").set_text("Maddy HP"+str(player.maddyhp)+"\nMP"+str(player.maddymp))
	self.get_node("Heroes/Ted/RichTextLabel").set_text("Ted HP"+str(player.tedhp)+"\nMP"+str(player.tedmp))
	self.get_node("Heroes/Sam/RichTextLabel").set_text("Sam HP"+str(player.samhp)+"\nMP"+str(player.sammp))
	self.get_node("Heroes/Rose/RichTextLabel").set_text("Rose HP"+str(player.rosehp)+"\nMP"+str(player.rosemp))
	
func _process(delta):
	if(turn==0 and done):
		if(hp[0]<=0):
			turn+=1
			done=true
		else:
			done=false
			self.get_node("RichTextLabel").set_text("Monster 1 is going to attack!")
			var t = Timer.new() 
			t.set_wait_time(3)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			_on_MonsterAttack_pressed()
			t = Timer.new() 
			t.set_wait_time(2)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			turn+=1
			done=true
	if(turn==1 and done):
		if(hp[1]<=0):
			turn+=1
			done=true
		else:
			done=false
			self.get_node("RichTextLabel").set_text("Monster 2 is going to attack!")
			var t = Timer.new() 
			t.set_wait_time(3)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			_on_MonsterAttack_pressed()
			t = Timer.new() 
			t.set_wait_time(2)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			turn+=1
			done=true
	if(turn==2 and done):
		if(hp[2]<=0):
			turn+=1
			done=true
		else:
			done=false
			self.get_node("RichTextLabel").set_text("Monster 3 is going to attack!")
			var t = Timer.new() 
			t.set_wait_time(3)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			_on_MonsterAttack_pressed()
			t = Timer.new() 
			t.set_wait_time(2)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			turn+=1
			done=true
	if(turn==3 and done):
		if(player.tedhp<=0):
			turn+=1
			done=true
			playerdone=true
		else:
			done=false
			playerdone=false
			self.get_node("RichTextLabel").set_text("Ted is going to attack!")
			var t = Timer.new() 
			t.set_wait_time(2)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			self.get_node("TEMP").visible=true
#			_on_PlayerAttack_pressed()
			while(not playerdone):
				t = Timer.new() 
				t.set_wait_time(2)
				t.set_one_shot(true)
				self.add_child(t)
				t.start()
				yield(t, "timeout")
				t.queue_free()
			turn+=1
			done=playerdone	
	if(turn==4 and done):
		if(player.maddyhp<=0):
			turn+=1
			if(turn>numturns):
				turn=0
			playerdone=false
			done=true
		else:
			playerdone=false
			done=false
			self.get_node("RichTextLabel").set_text("Maddy is going to attack!")
			var t = Timer.new() 
			t.set_wait_time(2)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			self.get_node("TEMP").visible=true
			#_on_PlayerAttack_pressed()
			while(not playerdone):
				t = Timer.new() 
				t.set_wait_time(2)
				t.set_one_shot(true)
				self.add_child(t)
				t.start()
				yield(t, "timeout")
				t.queue_free()
			turn+=1
			if(turn>numturns):
				turn=0
			done=playerdone
	if(turn==5 and done):
		if(player.samhp<=0):
			turn+=1
			if(turn>numturns):
				turn=0
			playerdone=false
			done=true
		else:
			playerdone=false
			done=false
			self.get_node("RichTextLabel").set_text("Sam is going to attack!")
			var t = Timer.new() 
			t.set_wait_time(2)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			self.get_node("TEMP").visible=true
			#_on_PlayerAttack_pressed()
			while(not playerdone):
				t = Timer.new() 
				t.set_wait_time(2)
				t.set_one_shot(true)
				self.add_child(t)
				t.start()
				yield(t, "timeout")
				t.queue_free()
			turn+=1
			if(turn>numturns):
				turn=0
			done=playerdone
	if(turn==6 and done):
		if(player.rosehp<=0):
			turn+=1
			if(turn>numturns):
				turn=0
			playerdone=false
			done=true
		else:
			playerdone=false
			done=false
			self.get_node("RichTextLabel").set_text("Rose is going to attack!")
			var t = Timer.new() 
			t.set_wait_time(2)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			self.get_node("TEMP").visible=true
			#_on_PlayerAttack_pressed()
			while(not playerdone):
				t = Timer.new() 
				t.set_wait_time(2)
				t.set_one_shot(true)
				self.add_child(t)
				t.start()
				yield(t, "timeout")
				t.queue_free()
			turn+=1
			if(turn>numturns):
				turn=0
			done=playerdone


func setupMonsters(type):
	#TEMP METHOD, important for when we have more than 1 type of monster
	xpgain = 10
	gpgain = 2
	nummonsters = 3
	monstr = 2
	mondef = 2
	mondmg=2
	self.get_node("Enemies/Monster/RichTextLabel").set_text("HP"+str(hp[0]))
	self.get_node("Enemies/Monster2/RichTextLabel").set_text("HP"+str(hp[1]))
	self.get_node("Enemies/Monster3/RichTextLabel").set_text("HP"+str(hp[2]))	


func get_input()->bool:
	if(Input.is_key_pressed(KEY_A)):
		return true
	return false

func enemyattack(target):
	var delta=0
	self.get_node("RichTextLabel").set_text("5")
	endattack=false
	endattack =get_input()
	if(not endattack):
		endattack =get_input()
		var t = Timer.new() 
		t.set_wait_time(0.2)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free()
		delta=1
		self.get_node("RichTextLabel").set_text("5")
	if(not endattack):
		endattack = get_input()
		var t = Timer.new() 
		t.set_wait_time(0.2)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free()
		delta=2
		self.get_node("RichTextLabel").set_text("4")
	if(not endattack):
		endattack =get_input()
		var t = Timer.new() 
		t.set_wait_time(0.2)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free()
		delta=3
		self.get_node("RichTextLabel").set_text("3")
	if(not endattack):
		endattack =get_input()
		var t = Timer.new() 
		t.set_wait_time(0.2)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free()
		delta=4
		self.get_node("RichTextLabel").set_text("2")
	if(not endattack):
		endattack =get_input()
		var t = Timer.new() 
		t.set_wait_time(0.2)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free()
		delta=5
		self.get_node("RichTextLabel").set_text("1")
	if(not endattack):
		endattack =get_input()
		var t = Timer.new() 
		t.set_wait_time(0.2)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free()
		delta=6
		self.get_node("RichTextLabel").set_text("0")
	var t = 1
	delta = 6-delta
	if(not endattack):
		delta=6
	if (delta<=1):
		doDamageEffect(target,false)
		self.get_node("RichTextLabel").set_text("GOOD BLOCK")
		t=.75
	elif(delta<=5):
		doDamageEffect(target,false)
		self.get_node("RichTextLabel").set_text("HIT")
		t=1
	else:
		doDamageEffect(target,false)
		self.get_node("RichTextLabel").set_text("AWFUL TIMING")
		t=1.25
	if(target=="Ted"):
		var dmg = int(max(1,(monstr+mondmg-player.teddef)*t))
		player.dealDamage(dmg, target)
	elif(target=="Maddy"):
		var dmg = int(max(1,(monstr+mondmg-player.maddydef)*t))
		player.dealDamage(dmg, target)
	elif(target=="Sam"):
		var dmg = int(max(1,(monstr+mondmg-player.samdef)*t))
		player.dealDamage(dmg, target)
	elif(target=="Rose"):
		var dmg = int(max(1,(monstr+mondmg-player.rosedef)*t))
		player.dealDamage(dmg, target)
	if(player.maddyhp==0):
		self.get_node("Heroes/Maddy").visible=false
	if(player.tedhp==0):
		self.get_node("Heroes/Ted").visible=false
	if(player.samhp==0 and Global.samexist):
		self.get_node("Heroes/Sam").visible=false
	if(player.rosehp==0 and Global.roseexist):
		self.get_node("Heroes/Rose").visible=false
	if(player.incapacitated):
		self.queue_free()
		Global.unfreeze()
	self.get_node("Heroes/Maddy/RichTextLabel").set_text("Maddy HP"+str(player.maddyhp)+"\nMP"+str(player.maddymp))
	self.get_node("Heroes/Ted/RichTextLabel").set_text("Ted HP"+str(player.tedhp)+"\nMP"+str(player.tedmp))
	self.get_node("Heroes/Sam/RichTextLabel").set_text("Sam HP"+str(player.samhp)+"\nMP"+str(player.sammp))
	self.get_node("Heroes/Rose/RichTextLabel").set_text("Rose HP"+str(player.rosehp)+"\nMP"+str(player.rosemp))
	
func playerattack(target,user):
	if(not hp[target-1]<=0):
		var delta=0
		self.get_node("RichTextLabel").set_text("5")
		endattack=false
		endattack =get_input()
		if(not endattack):
			endattack =get_input()
			var t = Timer.new() 
			t.set_wait_time(0.2)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			delta=1
			self.get_node("RichTextLabel").set_text("5")
		if(not endattack):
			endattack = get_input()
			var t = Timer.new() 
			t.set_wait_time(0.2)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			delta=2
			self.get_node("RichTextLabel").set_text("4")
		if(not endattack):
			endattack =get_input()
			var t = Timer.new() 
			t.set_wait_time(0.2)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			delta=3
			self.get_node("RichTextLabel").set_text("3")
		if(not endattack):
			endattack =get_input()
			var t = Timer.new() 
			t.set_wait_time(0.2)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			delta=4
			self.get_node("RichTextLabel").set_text("2")
		if(not endattack):
			endattack =get_input()
			var t = Timer.new() 
			t.set_wait_time(0.2)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			delta=5
			self.get_node("RichTextLabel").set_text("1")
		if(not endattack):
			endattack =get_input()
			var t = Timer.new() 
			t.set_wait_time(0.2)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			delta=6
			self.get_node("RichTextLabel").set_text("0")
		
		var t = 1 #timing modifier
		if (delta<= 1 or endattack==false):
			doDamageEffect(target,true)
			self.get_node("RichTextLabel").set_text("WEAK")
		elif(delta<=4):
			doDamageEffect(target,true)
			self.get_node("RichTextLabel").set_text("HIT")
			t=1.25
		else:
			doDamageEffect(target,true)
			self.get_node("RichTextLabel").set_text("NICE TIMING")
			t=1.5
		
		if(user=="Ted"):
			hp[target-1]-=int(max(1,(player.tedstr+player.tedweap-mondef)*t))
		elif(user=="Tedspecial"):
			hp[target-1]-=int(max(1,(player.tedstr+player.tedweap-mondef)*1.2*t))
		elif(user =="Maddy"):
			hp[target-1]-=int(max(1,(player.maddystr+player.maddyweap-mondef)*t))
		elif(user =="Sam"):
			hp[target-1]-=int(max(1,(player.samstr+player.samweap-mondef)*t))
		elif(user=="Samspecial"):
			hp[0]-=int(max(1,(player.samstr+player.samweap-mondef)*.5*t))
			hp[1]-=int(max(1,(player.samstr+player.samweap-mondef)*.5*t))
			hp[2]-=int(max(1,(player.samstr+player.samweap-mondef)*.5*t))
		elif(user =="Rose"):
			hp[target-1]-=int(max(1,(player.rosestr+player.roseweap-mondef)*t))
		
		var down = 0
		if(hp[0]<=0):
			down+=1
			self.get_node("Enemies/Monster").visible = false
		if(hp[1]<=0):
			down+=1
			self.get_node("Enemies/Monster2").visible = false
		if(hp[2]<=0):
			down+=1
			self.get_node("Enemies/Monster3").visible = false
		nummonsters=3-down
		if(nummonsters<=0):
			_on_Win_pressed()
		
	#	if(hp[target-1]<=0):
	#		if(target==1):
	#			self.get_node("Enemies/Monster").visible = false
	#		elif(target==2):
	#			self.get_node("Enemies/Monster2").visible = false
	#		elif(target==3):
	#			self.get_node("Enemies/Monster3").visible = false
	#		nummonsters-=1
	#		if(nummonsters<=0):
	#			_on_Win_pressed()
		self.get_node("Enemies/Monster/RichTextLabel").set_text("HP"+str(hp[0]))
		self.get_node("Enemies/Monster2/RichTextLabel").set_text("HP"+str(hp[1]))
		self.get_node("Enemies/Monster3/RichTextLabel").set_text("HP"+str(hp[2]))	
	playerdone=true
	
func doDamageEffect(target, type):
	#type is true for monsters and false for heroes
	var node
	if(type):
		if(target==0):
			node = self.get_node("Enemies/Monster")
			doDamageEffect(2, true)
			doDamageEffect(3, true)
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
		elif(target=="Sam"):
			node=self.get_node("Heroes/Sam")
		elif(target=="Rose"):
			node=self.get_node("Heroes/Rose")
	node.modulate.a = 0.5
	var t = Timer.new() #time spent being invulnerable
	t.set_wait_time(0.2)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	node.modulate.a = 1
	t.queue_free()
	

	

func playerspecial(user, target):
	if(player.useMP(5, user)):
		if(user=="Ted"):
			self.get_node("RichTextLabel").set_text("Major League Baseball Featuring Ken Griffey Jr.!")
			playerattack(target, "Tedspecial")
		if(user=="Maddy"):
			self.get_node("RichTextLabel").set_text("Maddy heals "+ target)
			player.healchar(5, target)
			playerdone=true
		if(user=="Sam"):
			self.get_node("RichTextLabel").set_text("Magnemite Lv 13!")
			playerattack(0, "Samspecial")
		if(user=="Rose"):
			self.get_node("RichTextLabel").set_text("Rose throws pocket sand??? I DIDN'T CODE THIS YET D:")
			playerdone=true
		self.get_node("Heroes/Maddy/RichTextLabel").set_text("Maddy HP"+str(player.maddyhp)+"\nMP"+str(player.maddymp))
		self.get_node("Heroes/Ted/RichTextLabel").set_text("Ted HP"+str(player.tedhp)+"\nMP"+str(player.tedmp))
		self.get_node("Heroes/Sam/RichTextLabel").set_text("Sam HP"+str(player.samhp)+"\nMP"+str(player.sammp))
		self.get_node("Heroes/Rose/RichTextLabel").set_text("Rose HP"+str(player.rosehp)+"\nMP"+str(player.rosemp))
	else:
		self.get_node("RichTextLabel").set_text("OUT OF MP")

#TEMP METHODS FOR TESTING BATTLE WIN AND LOSS STUFF
func _on_Win_pressed():
	self.get_node("RichTextLabel").set_text("YOU WIN")
	var t = Timer.new() 
	t.set_wait_time(1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	player.addXP(xpgain)
	player.doTransaction(gpgain, true)
	Global.freeze=false
	if(player.tedhp==0):
		player.healchar(1,"Ted")
	if(player.maddyhp==0):
		player.healchar(1,"Maddy")
	if(player.samhp==0):
		player.healchar(1,"Sam")
	if(player.rosehp==0):
		player.healchar(1,"Rose")
	self.queue_free()


func _on_Lose_pressed():
	self.get_node("RichTextLabel").set_text("YOU LOSE")
	var t = Timer.new() 
	t.set_wait_time(1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	t.queue_free()
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
	var i = 0
	var choices = PoolStringArray()
	if(self.get_node("Heroes/Maddy").visible):
		i+=1
		choices.append("Maddy")
	if(self.get_node("Heroes/Ted").visible):
		i+=1
		choices.append("Ted")
	if(self.get_node("Heroes/Rose").visible):
		i+=1
		choices.append("Rose")
	if(self.get_node("Heroes/Sam").visible):
		i+=1
		choices.append("Sam")
	var rand = randi()%i
	var ans = Array(choices)
	return ans[rand]


	
func _on_PlayerAttack_pressed():
	self.get_node("TEMP").visible=false
	var i=0
	while(hp[i]<=0):
		i+=1
		if(i>=3):
			i=0
	self.get_node("RichTextLabel").set_text("Target = Monster "+str(i+1))
	var enter = false
	while (not enter):
		var t = Timer.new() 
		t.set_wait_time(.1)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		t.queue_free()
		enter=Input.is_key_pressed(KEY_ENTER)
		if(Input.is_key_pressed(KEY_UP)):
			i+=1
			if(i>=3):
				i=0
			while(hp[i]<=0):
				i+=1
				if(i>=3):
					i=0
			self.get_node("RichTextLabel").set_text("Target = Monster "+str(i+1))
		if(Input.is_key_pressed(KEY_DOWN)):
			i-=1
			if(i<0):
				i=2
			while(hp[i]<=0):
				i-=1
				if(i<0):
					i=2
			self.get_node("RichTextLabel").set_text("Target = Monster "+str(i+1))
	if(turn==3):
		playerattack(i+1,"Ted")
	elif(turn==4):
		playerattack(i+1,"Maddy")
	elif(turn==5):
		playerattack(i+1,"Sam")
	elif(turn==6):
		playerattack(i+1,"Rose")


func _on_PlayerSpecial_pressed():
	self.get_node("TEMP").visible=false
	var user =randomHero()
	if(turn==3):
		user="Ted"
	elif(turn==4):
		user="Maddy"
	elif(turn==5):
		user="Sam"
	elif(turn==6):
		user="Rose"
	var target
	if(user=="Maddy"):
		target="Maddy"
		if(player.tedhp>0):
			self.get_node("RichTextLabel").set_text("Target = "+target)
			var enter = false
			while (not enter):
				var t = Timer.new() 
				t.set_wait_time(.1)
				t.set_one_shot(true)
				self.add_child(t)
				t.start()
				yield(t, "timeout")
				t.queue_free()
				enter=Input.is_key_pressed(KEY_ENTER)
				if(Input.is_key_pressed(KEY_UP)):
					if(target=="Maddy"):
						if(player.tedhp>0):
							target="Ted"
						elif(Global.samexist and player.samhp>0):
							target="Sam"
						elif(Global.roseexist and player.rosehp>0):
							target="Rose"
						else:
							target="Maddy"
					elif(target=="Ted"):
						if(Global.samexist and player.samhp>0):
							target="Sam"
						elif(Global.roseexist and player.rosehp>0):
							target="Rose"
						else:
							target="Maddy"
					elif(target=="Sam"):
						if(Global.roseexist and player.rosehp>0):
							target="Rose"
						else:
							target="Maddy"
					elif(target=="Rose"):
						target="Maddy"
					self.get_node("RichTextLabel").set_text("Target = "+target)
				if(Input.is_key_pressed(KEY_DOWN)):
					if(target=="Maddy"):
						if(Global.roseexist and player.rosehp>0):
							target="Rose"
						elif(Global.samexist and player.samhp>0):
							target="Sam"
						elif(player.tedhp>0):
							target="Ted"
						else:
							target="Maddy"
					elif(target=="Ted"):
							target="Maddy"
					elif(target=="Sam"):
						if(player.tedhp>0):
							target="Ted"
						else:
							target="Maddy"
					elif(target=="Rose"):
						if(Global.samexist and player.samhp>0):
							target="Sam"
						elif(player.tedhp>0):
							target="Ted"
						else:
							target="Maddy"
					
					self.get_node("RichTextLabel").set_text("Target = "+target)
	elif(user=="Ted"):
		var i=0
		while(hp[i]<=0):
			i+=1
			if(i>=3):
				i=0
		self.get_node("RichTextLabel").set_text("Target = Monster "+str(i+1))
		var enter = false
		while (not enter):
			var t = Timer.new() 
			t.set_wait_time(.1)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			enter=Input.is_key_pressed(KEY_ENTER)
			if(Input.is_key_pressed(KEY_UP)):
				i+=1
				if(i>=3):
					i=0
				while(hp[i]<=0):
					i+=1
					if(i>=3):
						i=0
				self.get_node("RichTextLabel").set_text("Target = Monster "+str(i+1))
			if(Input.is_key_pressed(KEY_DOWN)):
				i-=1
				if(i<0):
					i=2
				while(hp[i]<=0):
					i-=1
					if(i<0):
						i=2
				self.get_node("RichTextLabel").set_text("Target = Monster "+str(i+1))
		target=i+1
	playerspecial(user, target)


func _on_MonsterAttack_pressed():
	var target = randomHero()
	enemyattack(target)
	pass # Replace with function body.
