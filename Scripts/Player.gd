extends KinematicBody2D

var gp = 200

var tedmaxhp = 10
var tedhp = 10
var tedxp = 5
var tedspd = 5
var tedmaxmp = 8
var tedmp = 8
var tedstr = 3
var teddef = 2
var tedweap = 3
var tedlvl = 1
var tednxtlvl = 10

var maddymaxhp = 8
var maddyhp = 8
var maddyxp = 5
var maddyspd = 5
var maddymaxmp = 15
var maddymp = 15
var maddystr = 1
var maddydef = 1
var maddyweap = 3
var maddylvl=1
var maddynxtlvl = 10

var sammaxhp = 9
var samhp = 9
var samxp = 0
var samspd = 5
var sammaxmp = 10
var sammp = 10
var samstr = 2
var samdef = 1
var samweap = 3
var samlvl=1
var samnxtlvl = 10

var rosemaxhp = 9
var rosehp = 9
var rosexp = 0
var rosespd = 5
var rosemaxmp = 8
var rosemp = 8
var rosestr = 2
var rosedef = 2
var roseweap = 3
var roselvl=1
var rosenxtlvl = 10

var incapacitated = false
var invulnerable = false
var lastheal = Vector2()

var velocity = Vector2()
var speed = 300
var sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	lastheal=position
	sprite = self.get_node("MaddySprite")
	#changeLeader("Ted")
	self.get_node("Display/CanvasLayer/Labels").set_text("Ted HP:"+(str(tedhp)+"\n"+"Maddy HP:"+(str(maddyhp))+"\n"+"GP:"+str(gp)))

func get_input():
	velocity = Vector2()
	if Input.is_action_just_released("ui_right"):
		sprite.play("idleside")
	if Input.is_action_just_released("ui_left"):
		sprite.play("idleside")
	if Input.is_action_just_released("ui_up"):
		sprite.play("idleup")
	if Input.is_action_just_released("ui_down"):
		sprite.play("idledown")
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		self.get_node("RayCast2D").set_rotation_degrees(-90)
		sprite.play("walkside")
		sprite.set_flip_h(false)
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		self.get_node("RayCast2D").set_rotation_degrees(90)
		sprite.play("walkside")
		sprite.set_flip_h(true)
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
		self.get_node("RayCast2D").set_rotation_degrees(180)
		sprite.play("walkup")
		sprite.set_flip_h(false)
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		self.get_node("RayCast2D").set_rotation_degrees(0)
		sprite.play("walkdown")
		sprite.set_flip_h(false)
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	if(incapacitated):
		invulnerable = false
		self.position=lastheal
		tedhp = tedmaxhp
		maddyhp=maddymaxhp
		samhp=sammaxhp
		rosehp=rosemaxhp
		incapacitated=false
		self.get_node("Display/CanvasLayer/Labels").set_text("Ted HP:"+(str(tedhp)+"\n"+"Maddy HP:"+(str(maddyhp))+"\n"+"GP:"+str(gp)))
	if Global.freeze:
		if Input.is_action_just_released("ui_right"):
			sprite.play("idleside")
		if Input.is_action_just_released("ui_left"):
			sprite.play("idleside")
		if Input.is_action_just_released("ui_up"):
			sprite.play("idleup")
		if Input.is_action_just_released("ui_down"):
			sprite.play("idledown")
	if not Global.freeze:
		get_input()
		velocity = move_and_slide(velocity)

func changeLeader(lead):
	if(lead=="Ted"):
		sprite.visible=false
		sprite=self.get_node("TedSprite")
		sprite.visible=true
	elif(lead=="Sam"):
		sprite.visible=false
		sprite=self.get_node("SamSprite")
		sprite.visible=true
	elif(lead=="Rose"):
		sprite.visible=false
		sprite=self.get_node("RoseSprite")
		sprite.visible=true
	else:
		sprite.visible=false
		sprite=self.get_node("MaddySprite")
		sprite.visible=true
	
	pass

func lvlup(target):
	if(target=="Ted"):
		tedmaxhp+=3
		tedmaxmp+=1
		teddef+=randi()%2
		tedstr+=randi()%2
		tedspd+=randi()%2
		tednxtlvl = 2*tednxtlvl
		tedlvl+=1
	elif(target=="Maddy"):
		maddymaxhp+=1
		maddymaxmp+=3
		maddydef+=randi()%2
		maddystr+=randi()%2
		maddyspd+=randi()%2
		maddynxtlvl = 2*maddynxtlvl
		maddylvl+=1
	elif(target=="Rose"):
		rosemaxhp+=2
		rosemaxmp+=2
		rosedef+=randi()%2
		rosestr+=randi()%2
		rosespd+=randi()%2
		rosenxtlvl=2*rosenxtlvl
		roselvl+=1
	elif(target=="Sam"):
		sammaxhp+=1
		sammaxhp+=3
		samdef+=randi()%2
		samstr+=randi()%2
		samspd+=randi()%2
		samnxtlvl=2*samnxtlvl
		samlvl+=1

func dealDamage(damage, target):
	if(target=="Ted"):
		tedhp-=damage
		if tedhp<=0:
			tedhp=0
	elif(target=="Maddy"):
		maddyhp-=damage
		if maddyhp<=0:
			maddyhp=0
	elif(target=="Rose"):
		rosehp-=damage
		if rosehp<=0:
			rosehp=0
	elif(target=="Sam"):
		samhp-=damage
		if samhp<=0:
			samhp=0
	if(maddyhp == 0 and tedhp==0):
		if not Global.samexist and not Global.roseexist:
			incapacitated=true
		elif(samhp==0 and not Global.roseexist):
			incapacitated=true
		elif(rosehp==0 and not Global.samexist):
			incapacitated=true
		elif(rosehp==0 and samhp==0):
			incapacitated=true
	self.get_node("Display/CanvasLayer/Labels").set_text("Ted HP:"+(str(tedhp)+"\n"+"Maddy HP:"+(str(maddyhp))+"\n"+"GP:"+str(gp)))

func useMP(amount, target) -> bool:
	if(target=="Ted"):
		tedmp-=amount
		if(tedmp>=0):
			return true
		else:
			tedmp+=amount
			return false
	elif(target=="Maddy"):
		maddymp-=amount
		if(maddymp>=0):
			return true
		else:
			maddymp+=amount
			return false
	elif(target=="Sam"):
		sammp-=amount
		if(sammp>=0):
			return true
		else:
			sammp+=amount
			return false
	elif(target=="Rose"):
		rosemp-=amount
		if(rosemp>=0):
			return true
		else:
			rosemp+=amount
			return false
	return false
		
func restoreMP(amount, target):
	if(target=="Ted"):
		tedmp+=amount
		if tedmp>tedmaxmp:
			tedmp=tedmaxmp
	elif(target=="Maddy"):
		maddymp+=amount
		if maddymp>maddymaxmp:
			maddymp=maddymaxmp
	elif(target=="Sam"):
		sammp+=amount
		if sammp>sammaxmp:
			sammp=sammaxmp
	elif(target=="Rose"):
		rosemp+=amount
		if rosemp>rosemaxmp:
			rosemp=rosemaxmp

func healchar(amount, target):
	if(target=="Ted"):
		tedhp+=amount
		if tedhp>tedmaxhp:
			tedhp=tedmaxhp
	elif(target=="Maddy"):
		maddyhp+=amount
		if maddyhp>maddymaxhp:
			maddyhp=maddymaxhp
	elif(target=="Sam"):
		samhp+=amount
		if samhp>sammaxhp:
			samhp=sammaxhp
	elif(target=="Rose"):
		rosehp+=amount
		if rosehp>rosemaxhp:
			rosehp=rosemaxhp
	self.get_node("Display/CanvasLayer/Labels").set_text("Ted HP:"+(str(tedhp)+"\n"+"Maddy HP:"+(str(maddyhp))+"\n"+"GP:"+str(gp)))

func heal(amount):
	healchar(amount, "Ted")
	healchar(amount, "Maddy")
	healchar(amount, "Sam")
	healchar(amount, "Rose")
	self.get_node("Display/CanvasLayer/Labels").set_text("Ted HP:"+(str(tedhp)+"\n"+"Maddy HP:"+(str(maddyhp))+"\n"+"GP:"+str(gp)))

func resetHealth():
	lastheal=position
	tedhp=tedmaxhp
	tedmp=tedmaxmp
	maddyhp=maddymaxhp
	maddymp=maddymaxmp
	samhp=sammaxhp
	sammp=sammaxmp
	rosehp=rosemaxhp
	rosemp=rosemaxmp
	self.get_node("Display/CanvasLayer/Labels").set_text("Ted HP:"+(str(tedhp)+"\n"+"Maddy HP:"+(str(maddyhp))+"\n"+"GP:"+str(gp)))

func doTransaction(amount, type) ->bool:
	#type = true when adding money
	#type = false when taking money
	if(type):
		gp+=amount
		self.get_node("Display/CanvasLayer/Labels").set_text("Ted HP:"+(str(tedhp)+"\n"+"Maddy HP:"+(str(maddyhp))+"\n"+"GP:"+str(gp)))
		return true
	else:
		if gp<amount:
			print("failed transaction")
			return false
		else:
			gp-=amount
			self.get_node("Display/CanvasLayer/Labels").set_text("Ted HP:"+(str(tedhp)+"\n"+"Maddy HP:"+(str(maddyhp))+"\n"+"GP:"+str(gp)))
			return true

func addXP(amount):
	tedxp+=amount
	maddyxp+=amount
	if(Global.samexist):
		samxp+=amount
	if(Global.roseexist):
		rosexp+=amount


func overworld_damage(amount):
	if(not invulnerable):
		invulnerable = true
		dealDamage(amount, "Ted")
		dealDamage(amount, "Maddy")
		if(Global.roseexist):
			dealDamage(amount, "Rose")
		if(Global.samexist):
			dealDamage(amount, "Sam")
		self.modulate.a = 0.5
		var t = Timer.new() #time spent being invulnerable
		t.set_wait_time(0.3)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		self.modulate.a = 1
		t.queue_free()
		invulnerable = false
	
	

