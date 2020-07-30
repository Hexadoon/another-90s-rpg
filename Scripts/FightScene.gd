extends Node


var player
var sound
var xpgain
var gpgain
var hp = [1, 1, 1]
var monstertype
var nummonsters
var endattack
var turn
var numturns
var monstr
var mondef
var mondmg
var sanded

#MONSTER STATS SET DURING SETUPMONSTERS

var playerturn = false
var playerdone
var done
var battleover = false

# Called when the node enters the scene tree for the first time.
func _ready():
	sound = self.get_node("AudioStreamPlayer")
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
	
	sanded=-1
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
	if(not battleover):
		if(turn==0 and done):
			if(hp[0]<=0):
				turn+=1
				done=true
			elif(sanded==0):
				done=false
				self.get_node("RichTextLabel").set_text("Monster 1 takes the sand out of its eyes!")
				var t = Timer.new() 
				t.set_wait_time(3)
				t.set_one_shot(true)
				self.add_child(t)
				t.start()
				yield(t, "timeout")
				t.queue_free()
				sanded=-1
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

		if(turn==1 and done):
			if(hp[1]<=0):
				turn+=1
				done=true
			elif(sanded==1):
				done=false
				self.get_node("RichTextLabel").set_text("Monster 2 takes the sand out of its eyes!")
				var t = Timer.new() 
				t.set_wait_time(3)
				t.set_one_shot(true)
				self.add_child(t)
				t.start()
				yield(t, "timeout")
				t.queue_free()
				sanded=-1
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
				t.set_wait_time(4)
				t.set_one_shot(true)
				self.add_child(t)
				t.start()
				yield(t, "timeout")
				t.queue_free()

		if(turn==2 and done):
			if(hp[2]<=0):
				turn+=1
				done=true
			elif(sanded==2):
				done=false
				self.get_node("RichTextLabel").set_text("Monster 3 takes the sand out of its eyes!")
				var t = Timer.new() 
				t.set_wait_time(3)
				t.set_one_shot(true)
				self.add_child(t)
				t.start()
				yield(t, "timeout")
				t.queue_free()
				sanded=-1
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
				t.set_wait_time(4)
				t.set_one_shot(true)
				self.add_child(t)
				t.start()
				yield(t, "timeout")
				t.queue_free()

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
				while(not playerdone):
					t = Timer.new() 
					t.set_wait_time(2)
					t.set_one_shot(true)
					self.add_child(t)
					t.start()
					yield(t, "timeout")
					t.queue_free()
				turn+=1
				if(not battleover):
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
				while(not playerdone):
					t = Timer.new() 
					t.set_wait_time(2)
					t.set_one_shot(true)
					self.add_child(t)
					t.start()
					yield(t, "timeout")
					t.queue_free()
				turn+=1
				if(not battleover):
					done=playerdone
		if(turn==5 and done):
			if(player.samhp<=0 or Global.samexist==false):
				turn+=1
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
				if(not battleover):
					done=playerdone
		if(turn==6 and done):
			if(player.rosehp<=0 or Global.roseexist==false):
				turn+=1
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
				if(not battleover):
					done=playerdone
		if(turn==7 and done):
			turn=0


func setupMonsters(type):
	#TEMP METHOD, important for when we have more than 1 type of monster
	
	var modifier = (player.tedlvl+player.maddylvl)*1.5
	if(Global.samexist):
		modifier+=player.samlvl*1.5
	if(Global.roseexist):
		modifier+=player.roselvl*1.5
	modifier=int(modifier)
	hp[0]=max(3,randi()%modifier)
	hp[1]=max(3,randi()%modifier)
	hp[2]=max(3,randi()%modifier)
	xpgain = max(5,randi()%modifier)
	gpgain = max(5,randi()%modifier)
	nummonsters = 3
	monstr = 2
	mondef = 2
	mondmg = 2
	self.get_node("Enemies/Monster/RichTextLabel").set_text("HP"+str(hp[0]))
	self.get_node("Enemies/Monster2/RichTextLabel").set_text("HP"+str(hp[1]))
	self.get_node("Enemies/Monster3/RichTextLabel").set_text("HP"+str(hp[2]))	


func get_input()->bool:
	if(Input.is_key_pressed(KEY_A)):
		return true
	return false

func enemyattack(target):
	var nodetarget
	var nodeuser
	var startpos
	var endpos
	if(turn == 0):
		nodeuser=self.get_node("Enemies/Monster")
	elif(turn ==1):
		nodeuser=self.get_node("Enemies/Monster2")
	elif(turn ==2):
		nodeuser=self.get_node("Enemies/Monster3")
	if(target=="Ted"):
		nodetarget=self.get_node("Heroes/Ted")
	if(target=="Maddy"):
		nodetarget=self.get_node("Heroes/Maddy")
	if(target=="Rose"):
		nodetarget=self.get_node("Heroes/Rose")
	if(target=="Sam"):
		nodetarget=self.get_node("Heroes/Sam")
	nodeuser.get_node("Sprite").play("jump")
	startpos=nodeuser.position
	endpos=nodetarget.global_position
	nodeuser.z_index = 1
	var ti = Timer.new() 
	ti.set_wait_time(1)
	ti.set_one_shot(true)
	self.add_child(ti)
	ti.start()
	yield(ti, "timeout")
	nodeuser.global_position.x=endpos.x+150
	nodeuser.global_position.y=endpos.y
	ti.set_wait_time(.3)
	ti.start()
	yield(ti, "timeout")
	ti.queue_free()
	nodeuser.get_node("Sprite").play("idle")
	
	
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
		self.get_node("RichTextLabel").set_text("GOOD BLOCK")
		t=.75
	elif(delta<=5):
		self.get_node("RichTextLabel").set_text("HIT")
		t=1
	else:
		self.get_node("RichTextLabel").set_text("AWFUL TIMING")
		t=1.25
	sound.set_stream(preload("res://Game Ready Sounds/Toy Sword.wav"))
	sound.play()
	nodeuser.get_node("Sprite").play("attack")
	ti = Timer.new() 
	ti.set_wait_time(.5)
	ti.set_one_shot(true)
	self.add_child(ti)
	ti.start()
	yield(ti, "timeout")
	ti.queue_free()
	if(target=="Ted"):
		if(t==.75):
			self.get_node("Heroes/Ted/Sprite").play("block")
		else:
			self.get_node("Heroes/Ted/Sprite").play("hit")
		var dmg = int(max(1,(monstr+mondmg-player.teddef)*t))
		player.dealDamage(dmg, target)
		doDamageEffect(target,false)
		t = Timer.new() 
		t.set_wait_time(0.2)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		self.get_node("Heroes/Ted/Sprite").play("idle")
		t.queue_free()
	elif(target=="Maddy"):
		if(t==.75):
			self.get_node("Heroes/Maddy/Sprite").play("block")
		else:
			self.get_node("Heroes/Maddy/Sprite").play("hit")
		var dmg = int(max(1,(monstr+mondmg-player.maddydef)*t))
		player.dealDamage(dmg, target)
		doDamageEffect(target,false)
		t = Timer.new() 
		t.set_wait_time(0.2)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		self.get_node("Heroes/Maddy/Sprite").play("idle")
		t.queue_free()
	elif(target=="Sam"):
		if(t==.75):
			self.get_node("Heroes/Sam/Sprite").play("block")
		else:
			self.get_node("Heroes/Sam/Sprite").play("hit")
		var dmg = int(max(1,(monstr+mondmg-player.samdef)*t))
		player.dealDamage(dmg, target)
		doDamageEffect(target,false)
		t = Timer.new() 
		t.set_wait_time(0.2)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		self.get_node("Heroes/Sam/Sprite").play("idle")
		t.queue_free()
	elif(target=="Rose"):
		if(t==.75):
			self.get_node("Heroes/Rose/Sprite").play("block")
		else:
			self.get_node("Heroes/Rose/Sprite").play("hit")
		var dmg = int(max(1,(monstr+mondmg-player.rosedef)*t))
		player.dealDamage(dmg, target)
		doDamageEffect(target,false)
		t = Timer.new() 
		t.set_wait_time(0.1)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		self.get_node("Heroes/Rose/Sprite").play("idle")
		t.queue_free()
	nodeuser.get_node("Sprite").set_flip_h(true)
	nodeuser.get_node("Sprite").play("jump")
	t = Timer.new() 
	t.set_wait_time(1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	nodeuser.position=startpos
	nodeuser.get_node("Sprite").set_flip_h(false)
	t.set_wait_time(0.3)
	t.start()
	yield(t, "timeout")
	t.queue_free()
	nodeuser.get_node("Sprite").play("idle")
	
	if(player.maddyhp==0):
		self.get_node("Heroes/Maddy").visible=false
	if(player.tedhp==0):
		self.get_node("Heroes/Ted").visible=false
	if(player.samhp==0 and Global.samexist):
		self.get_node("Heroes/Sam").visible=false
	if(player.rosehp==0 and Global.roseexist):
		self.get_node("Heroes/Rose").visible=false
	if(player.incapacitated):
		Global.setting="NoFight"
		self.queue_free()
		Global.unfreeze()
	self.get_node("Heroes/Maddy/RichTextLabel").set_text("Maddy HP"+str(player.maddyhp)+"\nMP"+str(player.maddymp))
	self.get_node("Heroes/Ted/RichTextLabel").set_text("Ted HP"+str(player.tedhp)+"\nMP"+str(player.tedmp))
	self.get_node("Heroes/Sam/RichTextLabel").set_text("Sam HP"+str(player.samhp)+"\nMP"+str(player.sammp))
	self.get_node("Heroes/Rose/RichTextLabel").set_text("Rose HP"+str(player.rosehp)+"\nMP"+str(player.rosemp))
	turn+=1
	nodeuser.z_index = 0
	done=true

func playerattack(target,user):
	if(not hp[target-1]<=0):
		var nodetarget
		var nodeuser
		var startpos
		var endpos
		if(user=="Ted" or user == "Tedspecial"):
			nodeuser=self.get_node("Heroes/Ted")
			nodeuser.get_node("Sprite").play("jump")
			var t = Timer.new() 
			t.set_wait_time(1)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			nodeuser.get_node("Sprite").play("idle")
		elif(user=="Maddy"):
			nodeuser=self.get_node("Heroes/Maddy")
			nodeuser.get_node("Sprite").play("jump")
			var t = Timer.new() 
			t.set_wait_time(1)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			nodeuser.get_node("Sprite").play("idle")
		elif(user=="Rose"):
			nodeuser=self.get_node("Heroes/Rose")
			nodeuser.get_node("Sprite").play("jump")
			var t = Timer.new() 
			t.set_wait_time(1)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			nodeuser.get_node("Sprite").play("idle")
		elif(user=="Sam" or user =="Samspecial"):
			nodeuser=self.get_node("Heroes/Sam")
		startpos=nodeuser.global_position
		if(target==0):
			nodetarget = self.get_node("Enemies/Monster2")
		elif(target==1):
			nodetarget = self.get_node("Enemies/Monster")
		elif(target==2):
			nodetarget = self.get_node("Enemies/Monster2")
		elif(target==3):
			nodetarget=self.get_node("Enemies/Monster3")
		if(not (user=="Sam" or user=="Samspecial")):
			endpos=nodetarget.global_position
			nodeuser.global_position.x=endpos.x-150
			nodeuser.global_position.y=endpos.y
		
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
			self.get_node("RichTextLabel").set_text("WEAK")
		elif(delta<=4):
			self.get_node("RichTextLabel").set_text("HIT")
			t=1.25
		else:
			self.get_node("RichTextLabel").set_text("NICE TIMING")
			t=1.5
		
		if(user=="Ted"):
			sound.set_stream(preload("res://Game Ready Sounds/Bat Hit.wav"))
			sound.play()
			nodeuser.get_node("Sprite").play("attack")
			hp[target-1]-=int(max(1,(player.tedstr+player.tedweap-mondef)*t))
			t = Timer.new() 
			t.set_wait_time(0.3)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			doDamageEffect(target,true)
			t.start()
			yield(t, "timeout")
			t.queue_free()
		elif(user=="Tedspecial"):
			sound.set_stream(preload("res://Game Ready Sounds/Bat Hit.wav"))
			nodeuser.get_node("Sprite").play("special")
			hp[target-1]-=int(max(1,(player.tedstr+player.tedweap-mondef)*1.75*t))
			var hr =false
			if(t==1.5):
				self.get_node("RichTextLabel").set_text("HOME RUN!")
				hr=true
			t = Timer.new() 
			t.set_wait_time(.5)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			sound.play()
			t.set_wait_time(.3)
			t.start()
			yield(t, "timeout")
			doDamageEffect(target,true)
			if(hr):
				sound.set_stream(preload("res://Game Ready Sounds/Home Run!.wav"))
				sound.play()
				t.set_wait_time(.4)
				t.start()
				yield(t, "timeout")
				nodeuser.get_node("Sprite").play("idle")
				t.set_wait_time(1.6)
				t.start()
				yield(t, "timeout")
			t.set_wait_time(.4)
			t.start()
			yield(t, "timeout")
			t.queue_free()
		elif(user =="Maddy"):
			sound.set_stream(preload("res://Game Ready Sounds/Slashing Sound.wav"))
			sound.play()
			nodeuser.get_node("Sprite").play("attack")
			hp[target-1]-=int(max(1,(player.maddystr+player.maddyweap-mondef)*t))
			t = Timer.new() 
			t.set_wait_time(0.3)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			doDamageEffect(target,true)
			t.start()
			yield(t, "timeout")
			t.queue_free()
		elif(user =="Sam"):
			sound.set_stream(preload("res://Game Ready Sounds/Card Toss.wav"))
			sound.play()
			nodeuser.get_node("Sprite").play("attack")
			hp[target-1]-=int(max(1,(player.samstr+player.samweap-mondef)*t))
			t = Timer.new() 
			t.set_wait_time(0.3)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			doDamageEffect(target,true)
			t.start()
			yield(t, "timeout")
			t.queue_free()
		elif(user=="Samspecial"):
			sound.set_stream(preload("res://Game Ready Sounds/Boom.wav"))
			
			nodeuser.get_node("Sprite").play("special")
			hp[0]-=int(max(1,(player.samstr+player.samweap-mondef)*.5*t))
			hp[1]-=int(max(1,(player.samstr+player.samweap-mondef)*.5*t))
			hp[2]-=int(max(1,(player.samstr+player.samweap-mondef)*.5*t))
			t = Timer.new() 
			t.set_wait_time(0.3)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			sound.play()
			t.start()
			yield(t, "timeout")
			doDamageEffect(target,true)
			t.start()
			yield(t, "timeout")
			t.queue_free()
		elif(user =="Rose"):
			nodeuser.get_node("Sprite").play("attack")
			sound.set_stream(preload("res://Game Ready Sounds/Toy Sword.wav"))
			hp[target-1]-=int(max(1,(player.rosestr+player.roseweap-mondef)*t))
			t = Timer.new() 
			t.set_wait_time(0.3)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			sound.play()
			t.start()
			yield(t, "timeout")
			doDamageEffect(target,true)
			t.start()
			yield(t, "timeout")
			t.queue_free()
		if(not (user=="Sam" or user=="Samspecial")):
			nodeuser.get_node("Sprite").set_flip_h(true)
			if(user=="Maddy" or user=="Rose" or user=="Ted" or user=="Tedspecial"):
				nodeuser.get_node("Sprite").play("jump")
			t = Timer.new() 
			t.set_wait_time(1)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			nodeuser.global_position=startpos
			t = Timer.new() 
			t.set_wait_time(.2)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			nodeuser.get_node("Sprite").set_flip_h(false)
		if(user=="Maddy" or user=="Rose" or user=="Sam" or user == "Samspecial" or user=="Ted" or user=="Tedspecial"):
			nodeuser.get_node("Sprite").play("idle")

	
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
			battleover = true
			_on_Win_pressed()
		
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
		node.get_node("Sprite").play("hit")
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
	if(type):
		node.get_node("Sprite").play("idle")
	

	

func playerspecial(user, target):
	if(player.useMP(5, user)):
		if(user=="Ted"):
			self.get_node("RichTextLabel").set_text("Major League Baseball Featuring Ken Griffey Jr.!")
			playerattack(target, "Tedspecial")
		if(user=="Maddy"):
			self.get_node("RichTextLabel").set_text("Maddy heals "+ target)
			sound.set_stream(preload("res://Game Ready Sounds/Healing.wav"))
			if not target=="Maddy":
				var nodetarget
				var nodeuser = self.get_node("Heroes/Maddy")
				var startpos
				var endpos
				if(target=="Ted"):
					nodetarget=self.get_node("Heroes/Ted")
				if(target=="Sam"):
					nodetarget=self.get_node("Heroes/Sam")
				if(target=="Rose"):
					nodetarget=self.get_node("Heroes/Rose")
				nodeuser.get_node("Sprite").play("jump")
				var t = Timer.new() 
				t.set_wait_time(1)
				t.set_one_shot(true)
				self.add_child(t)
				t.start()
				yield(t, "timeout")
				
				endpos=nodetarget.global_position
				startpos=nodeuser.global_position
				nodeuser.global_position.x=endpos.x+75
				nodeuser.global_position.y=endpos.y
				nodeuser.get_node("Sprite").set_flip_h(true)
				nodeuser.get_node("Sprite").play("special")
				t.set_wait_time(0.6)
				t.start()
				yield(t, "timeout")
				nodeuser.get_node("Sprite").play("jump")
				t.set_wait_time(1)
				t.start()
				yield(t, "timeout")
				t.queue_free()
				nodeuser.global_position=startpos
				nodeuser.get_node("Sprite").set_flip_h(false)
				nodeuser.get_node("Sprite").play("idle")
			else:
				self.get_node("Heroes/Maddy/Sprite").play("selfheal")
				var t = Timer.new() 
				t.set_wait_time(0.8)
				t.set_one_shot(true)
				self.add_child(t)
				t.start()
				yield(t, "timeout")
				self.get_node("Heroes/Maddy/Sprite").play("idle")
			sound.play()
			player.healchar(5, target)
			playerdone=true
		if(user=="Sam"):
			self.get_node("RichTextLabel").set_text("Magnemite Lv 13!")
			playerattack(0, "Samspecial")
		if(user=="Rose"):
			var i =0
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
			sanded=i
			sound.set_stream(preload("res://Game Ready Sounds/Pocket Sand.wav"))
			self.get_node("Heroes/Rose/Sprite").play("special")
			sound.play()
			self.get_node("RichTextLabel").set_text("Rose throws pocket sand!")
			var t = Timer.new() 
			t.set_wait_time(1.5)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			self.get_node("Heroes/Rose/Sprite").play("idle")
			playerdone=true
		self.get_node("Heroes/Maddy/RichTextLabel").set_text("Maddy HP"+str(player.maddyhp)+"\nMP"+str(player.maddymp))
		self.get_node("Heroes/Ted/RichTextLabel").set_text("Ted HP"+str(player.tedhp)+"\nMP"+str(player.tedmp))
		self.get_node("Heroes/Sam/RichTextLabel").set_text("Sam HP"+str(player.samhp)+"\nMP"+str(player.sammp))
		self.get_node("Heroes/Rose/RichTextLabel").set_text("Rose HP"+str(player.rosehp)+"\nMP"+str(player.rosemp))
	else:
		self.get_node("RichTextLabel").set_text("OUT OF MP")
		self.get_node("TEMP").visible=true

#TEMP METHODS FOR TESTING BATTLE WIN AND LOSS STUFF
func _on_Win_pressed():
	battleover=true
	self.get_node("RichTextLabel").set_text("YOU WIN")
	var t = Timer.new() 
	t.set_wait_time(1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	player.addXP(xpgain)
	player.doTransaction(gpgain, true)
	if(player.tedxp>=player.tednxtlvl):
		player.lvlup("Ted")
		self.get_node("RichTextLabel").set_text("TED LEVELED UP")
		t.start()
		yield(t, "timeout")
	if(player.maddyxp>=player.maddynxtlvl):
		player.lvlup("Maddy")
		self.get_node("RichTextLabel").set_text("MADDY LEVELED UP")
		t.start()
		yield(t, "timeout")
	if(player.samxp>=player.samnxtlvl):
		player.lvlup("Sam")
		self.get_node("RichTextLabel").set_text("SAM LEVELED UP")
		t.start()
		yield(t, "timeout")
	if(player.rosexp>=player.rosenxtlvl):
		player.lvlup("Rose")
		self.get_node("RichTextLabel").set_text("ROSE LEVELED UP")
		t.start()
		yield(t, "timeout")
	t.queue_free()
	
	
	Global.freeze=false
	if(player.tedhp==0):
		player.healchar(1,"Ted")
	if(player.maddyhp==0):
		player.healchar(1,"Maddy")
	if(player.samhp==0):
		player.healchar(1,"Sam")
	if(player.rosehp==0):
		player.healchar(1,"Rose")
	Global.setting="NoFight"
	self.queue_free()


func _on_Lose_pressed():
	battleover=true
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
