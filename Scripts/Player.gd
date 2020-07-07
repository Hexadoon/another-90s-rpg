extends KinematicBody2D

var maxhp = 10
var hp = 10
var gp = 200
var xp = 0
var incapacitated = false
var invulnerable = false
var lastheal = Vector2()

var velocity = Vector2()
var speed = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	self.get_node("Display/CanvasLayer/Labels").set_text("HP:"+(str(hp)+"\n"+"GP:"+str(gp)))
	lastheal=position
	pass # Replace with function body.

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
		hp=maxhp
		incapacitated=false
		self.get_node(Display/CanvasLayer/Labels").set_text("HP:"+(str(hp)+"\n"+"GP:"+str(gp)))
	if not Global.freeze:
		get_input()
		velocity = move_and_slide(velocity)




func dealDamage(damage):
	hp-=damage
	if hp<= 0:
		hp=0
		incapacitated = true
	self.get_node("Display/CanvasLayer/Labels").set_text("HP:"+(str(hp)+"\n"+"GP:"+str(gp)))

func heal(amount):
	hp+=amount
	if hp>maxhp:
		hp=maxhp
	self.get_node("Display/CanvasLayer/Labels").set_text("HP:"+(str(hp)+"\n"+"GP:"+str(gp)))

func resetHealth():
	lastheal=position
	hp=maxhp
	self.get_node("Display/CanvasLayer/Labels").set_text("HP:"+(str(hp)+"\n"+"GP:"+str(gp)))

func doTransaction(amount, type) ->bool:
	#type = true when adding money
	#type = false when taking money
	if(type):
		gp+=amount
		self.get_node("Display/CanvasLayer/Labels").set_text("HP:"+(str(hp)+"\n"+"GP:"+str(gp)))
		return true
	else:
		if gp<amount:
			print("failed transaction")
			return false
		else:
			gp-=amount
			self.get_node("Display/CanvasLayer/Labels").set_text("HP:"+(str(hp)+"\n"+"GP:"+str(gp)))
			return true

func addXP(amount):
	xp+=amount

func overworld_damage(amount):
	if(not invulnerable):
		invulnerable = true
		dealDamage(amount)
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
	
	

