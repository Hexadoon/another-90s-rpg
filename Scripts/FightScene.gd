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

var playerturn = false
var done

# Called when the node enters the scene tree for the first time.
func _ready():
	player = self.get_parent().get_parent().get_parent().get_parent()
	monstertype = 0 #TEMP SETTING
	setupMonsters(monstertype)
	turn = 2
	done=true
	if(player.tedhp==0):
		player.healchar(1,"Ted")
	if(player.maddyhp==0):
		player.healchar(1,"Maddy")
	self.get_node("Heroes/Maddy/RichTextLabel").set_text("Maddy HP"+str(player.maddyhp)+"MP"+str(player.maddymp))
	self.get_node("Heroes/Ted/RichTextLabel").set_text("Ted HP"+str(player.tedhp)+"MP"+str(player.tedmp))

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
		else:
			done=false
			self.get_node("RichTextLabel").set_text("Ted is going to attack!")
			var t = Timer.new() 
			t.set_wait_time(3)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			_on_PlayerAttack_pressed()
			t = Timer.new() 
			t.set_wait_time(2)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			turn+=1
			done=true
		
	if(turn==4 and done):
		if(player.maddyhp<=0):
			turn=0
			done=true
		else:
			done=false
			self.get_node("RichTextLabel").set_text("Maddy is going to attack!")
			var t = Timer.new() 
			t.set_wait_time(3)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			_on_PlayerAttack_pressed()
			t = Timer.new() 
			t.set_wait_time(2)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			turn=0
			done=true
			


func setupMonsters(type):
	#TEMP METHOD, important for when we have more than 1 type of monster
	xpgain = 10
	gpgain = 2
	nummonsters = 3
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
	var dmg = (6-delta)*2
	print(str(dmg))
	if(dmg<0):
		dmg==0
	if(not endattack):
		dmg=10
	if (dmg<=1):
		self.get_node("RichTextLabel").set_text("GOOD BLOCK")
	elif(dmg<=8):
		doDamageEffect(target,false)
		self.get_node("RichTextLabel").set_text("HIT")
		player.dealDamage(dmg, target)
	else:
		doDamageEffect(target,false)
		self.get_node("RichTextLabel").set_text("AWFUL TIMING")
		player.dealDamage(dmg, target)
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
		var dmg = delta*2
		print(str(dmg))
		if (dmg<=3 or endattack==false):
			self.get_node("RichTextLabel").set_text("MISS")
		elif(dmg<=8):
			doDamageEffect(target,true)
			self.get_node("RichTextLabel").set_text("HIT")
			hp[target-1]-=dmg
		else:
			doDamageEffect(target,true)
			self.get_node("RichTextLabel").set_text("NICE TIMING")
			hp[target-1]-=dmg
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
	

	

func playerspecial(user, target):
	if(player.useMP(5, user)):
		if(user=="Ted"):
			self.get_node("RichTextLabel").set_text("Ted Goes All Out!")
			playerattack(target)
			var t = Timer.new() #time spent being invulnerable
			t.set_wait_time(1)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			playerattack(target)
			t = Timer.new() #time spent being invulnerable
			t.set_wait_time(1)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			playerattack(target)
			t = Timer.new() #time spent being invulnerable
			t.set_wait_time(1)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
			playerattack(target)
			t = Timer.new() #time spent being invulnerable
			t.set_wait_time(1)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			yield(t, "timeout")
			t.queue_free()
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
