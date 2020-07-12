extends KinematicBody2D

var gp = 200

var tedmaxhp = 10
var tedhp = 10
var tedxp = 0
var tedspd = 5

var maddymaxhp = 8
var maddyhp = 8
var maddyxp = 0
var maddyspd = 5

var incapacitated = false
var invulnerable = false
var lastheal = Vector2()

var velocity = Vector2()
var speed = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	lastheal=position
	changeLeader(0)
	self.get_node("Display/CanvasLayer/Labels").set_text("Ted HP:"+(str(tedhp)+"\n"+"Maddy HP:"+(str(maddyhp))+"\n"+"GP:"+str(gp)))

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
		self.get_node("RayCast2D").set_rotation_degrees(-90)
		self.get_node("Sprite").set_rotation_degrees(-90)
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		self.get_node("RayCast2D").set_rotation_degrees(90)
		self.get_node("Sprite").set_rotation_degrees(90)
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
		self.get_node("RayCast2D").set_rotation_degrees(180)
		self.get_node("Sprite").set_rotation_degrees(180)
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
		self.get_node("RayCast2D").set_rotation_degrees(0)
		self.get_node("Sprite").set_rotation_degrees(0)
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	if(incapacitated):
		invulnerable = false
		self.position=lastheal
		tedhp = tedmaxhp
		maddyhp=maddymaxhp
		incapacitated=false
		self.get_node("Display/CanvasLayer/Labels").set_text("Ted HP:"+(str(tedhp)+"\n"+"Maddy HP:"+(str(maddyhp))+"\n"+"GP:"+str(gp)))
	if not Global.freeze:
		get_input()
		velocity = move_and_slide(velocity)

func changeLeader(lead):
	pass


func dealDamage(damage, target):
	if(target=="Ted"):
		tedhp-=damage
		if tedhp<=0:
			tedhp=0
			changeLeader(1)
	elif(target=="Maddy"):
		maddyhp-=damage
		if maddyhp<=0:
			maddyhp=0
			changeLeader(0)
	if(maddyhp == 0 and tedhp==0):
		incapacitated=true
	self.get_node("Display/CanvasLayer/Labels").set_text("Ted HP:"+(str(tedhp)+"\n"+"Maddy HP:"+(str(maddyhp))+"\n"+"GP:"+str(gp)))

func healchar(amount, target):
	if(target=="Ted"):
		tedhp+=amount
		if tedhp>tedmaxhp:
			tedhp=tedmaxhp
	elif(target=="Maddy"):
		maddyhp+=amount
		if maddyhp>maddymaxhp:
			maddyhp=maddymaxhp
	self.get_node("Display/CanvasLayer/Labels").set_text("Ted HP:"+(str(tedhp)+"\n"+"Maddy HP:"+(str(maddyhp))+"\n"+"GP:"+str(gp)))

func heal(amount):
	healchar(amount, "Ted")
	healchar(amount, "Maddy")
	self.get_node("Display/CanvasLayer/Labels").set_text("Ted HP:"+(str(tedhp)+"\n"+"Maddy HP:"+(str(maddyhp))+"\n"+"GP:"+str(gp)))

func resetHealth():
	lastheal=position
	tedhp=tedmaxhp
	maddyhp=maddymaxhp
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


func overworld_damage(amount):
	if(not invulnerable):
		invulnerable = true
		dealDamage(amount, "Ted")
		dealDamage(amount, "Maddy")
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
	
	

