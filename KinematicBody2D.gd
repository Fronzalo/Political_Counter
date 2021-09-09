extends KinematicBody2D
export (int) var speed = 200
var velocity = Vector2()
onready var chargetimer = false
onready var m = 0
var reload_amount
var reload_time = 0.3
var bullet = preload("res://projectile.tscn")
var chargeshot = preload("res://chargeshot.tscn")
var state
var amount_meme
var amount_gun 
var amount_sign
var amount_words 
var inventory_pos = 1
var inventory_item
var libdeal = 1
var repdeal = 1

func reload():
	state = "reloading"
	$Sprite.hide()
	$Run_animation.hide()
	$reload_swap.show()
	$AnimationPlayer.play("reload_to")
	yield($AnimationPlayer, "animation_finished")
	$reload_swap.hide()
	$reload.show()
	state = "Actively Reloading"

func active_reload():
	$reload.hide()
	$reload_swap.hide()
	$reload_idle.show()
	$AnimationPlayer.play("reload_idle")
	if Input.is_action_just_pressed("shoot"):
		state = "page flip"
	if Input.is_action_just_pressed("Reload"):
		state = "leave reloading"

func page_flip():
	$reload_idle.hide()
	$reload.show()
	$AnimationPlayer.play("reload")
	yield($AnimationPlayer, "animation_finished")
	PlayerInfo.change_shots(1)
	state = "leave reloading"

func leave_reloading():
	$reload_idle.hide()
	$reload.hide()
	$reload_swap.show()
	$AnimationPlayer.play("reload_from")
	yield($AnimationPlayer, "animation_finished")
	$reload_swap.hide()
	state = null


func move():
	velocity.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	velocity.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	velocity = velocity.normalized() * speed
	velocity = move_and_slide(velocity)
	if velocity != Vector2.ZERO:
		$Sprite.hide()
		$Run_animation.show()
		if $ArmPosition.is_flipped == true:
			$AnimationPlayer.play("running_flipped")
		else:
			$AnimationPlayer.play("Running")
	else:
		$Run_animation.hide()
		$Sprite.show()
		if $ArmPosition.is_flipped == true:
			$AnimationPlayer.play("Idle_flipped")
		else:
			$AnimationPlayer.play("Idle")
	if Input.is_action_just_pressed("Reload"):
		state = "reload"
	if Input.is_action_just_pressed("shoot"):
		$chargetimer.start()
	if Input.is_action_just_released("shoot"):
		if chargetimer == true:
			charge_shoot()
			$chargetimer.stop()
			chargetimer = false
		else:
			shoot()
			$chargetimer.stop()
			chargetimer = false
	if Input.is_action_just_pressed("Inventory"):
		print("hello")
		state = "inventory"

func get_input():

	if state != "reloading" and state != "reload" and state != "Actively Reloading" and state != "page flip" and state != "leave reloading" and state != "inventory" and state != "Active Inventory" and state != "Leaving Inventory" and state != "Select":
		state = "moving"
	impliment_state()

func impliment_state():
	match(state):
		"reload":
			reload()
		"moving":
			move()
		"Actively Reloading":
			active_reload()
		"page flip":
			page_flip()
		"leave reloading":
			leave_reloading()
		"inventory":
			inventory()
		"Active Inventory":
			active_inventory()
		"Select":
			select()
		"Leaving Inventory":
			leave_inventory()
			

func inventory():
	$Sprite.hide()
	$Run_animation.hide()
	$reload_swap.show()
	$AnimationPlayer.play("reload_to")
	yield($AnimationPlayer, "animation_finished")
	$reload_swap.hide()
	$reload.show()
	$Inventory.show()
	state = "Active Inventory"

func active_inventory():
	$AnimationPlayer.play("reload_idle")
	if inventory_pos == 1:
		$Inventory/Selector/Amount.text = str(amount_meme)+"x"
	elif inventory_pos == 2: 
		$Inventory/Selector/Amount.text = str(amount_gun)+"x"
	elif inventory_pos == 3:
		$Inventory/Selector/Amount.text = str(amount_sign)+"x"
	elif inventory_pos == 4:
		$Inventory/Selector/Amount.text = str(amount_words)+"x"
	if Input.is_action_just_pressed("left") and inventory_pos <= 4:
		if inventory_pos == 2: 
			$Inventory/position.play("position_1")
			inventory_pos = 1
		elif inventory_pos == 3:
			$Inventory/position.play("position_2")
			inventory_pos = 2
		elif inventory_pos == 4:
			$Inventory/position.play("position_3")
			inventory_pos = 3
	if Input.is_action_just_pressed("right") and inventory_pos >= 1:
		if inventory_pos == 1: 
			$Inventory/position.play("position_2")
			print(inventory_pos)
			inventory_pos = 2
		elif inventory_pos == 2:
			$Inventory/position.play("position_3")
			inventory_pos = 3
		elif inventory_pos == 3:
			$Inventory/position.play("position_4")
			inventory_pos = 4
	if Input.is_action_just_pressed("Inventory"):
		state = "Leaving Inventory"
	if Input.is_action_just_pressed("select") or Input.is_action_just_pressed("shoot"):
		state = "Select"

func select():
	if inventory_pos == 1 and amount_meme >= 1:
		PlayerInfo.change_memes(-1)
		PlayerInfo.change_health(+4)
	elif inventory_pos == 2 and amount_gun >= 1:  
		PlayerInfo.change_guns(-1)
		libdeal = 2
		$Libtimer.start()
	elif inventory_pos == 3 and amount_sign >= 1:
		PlayerInfo.change_signs(-1)
		PlayerInfo.change_health(-4)
	elif inventory_pos == 4 and amount_words >= 1:
		PlayerInfo.change_words(-1)
		repdeal = 2
		$Reptimer.start()
	yield(get_tree(),"idle_frame")
	state = "Leaving Inventory"
		

func leave_inventory():
	$Inventory.hide()
	$reload_idle.hide()
	$reload.hide()
	$reload_swap.show()
	$AnimationPlayer.play("reload_from")
	yield($AnimationPlayer, "animation_finished")
	$reload_swap.hide()
	state = null




#	velocity = Vector2()
#	if reloading == false:
#		velocity.x = Input.get_action_strength("right") - Input.get_action_strength("left")
#		velocity.y = Input.get_action_strength("down") - Input.get_action_strength("up")
#		velocity = velocity.normalized() * speed
#
#	if Input.is_action_just_pressed("shoot") 
#		$chargetimer.start()
#	else: 
#		$AnimationPlayer.play("reload")
#		yield($AnimationPlayer, "animation_finished")
#		PlayerInfo.change_shots(+1)
#	if Input.is_action_just_released("shoot") and reloading == false:
#		if chargetimer == true:
#			charge_shoot()
#			$chargetimer.stop()
#			chargetimer = false
#		else:
#			shoot()
#			$chargetimer.stop()
#			chargetimer = false
#
#	if Input.is_action_just_pressed("Reload") and reloading == false:
#		reloading = true
#		$Sprite.hide()
#		$Run_animation.hide()
#		$reload_swap.show()
#		$AnimationPlayer.play("reload_to")
#		yield($AnimationPlayer, "animation_finished")
#		$reload_swap.hide()
#		$reload.show()
#		$AnimationPlayer.play("reload_idle")

		
#	if Input.is_action_just_pressed("shoot"):
#			shoot()
#	if Input.is_action_just_pressed("alt_fire"):
#		charge_shoot()



func _on_chargetimer_timeout():
	chargetimer = true
	print("Charged!")


func _process(delta):
	if PlayerInfo.get_health() <= 0 or PlayerInfo.get_health() >= 18:
		get_tree().reload_current_scene()
		PlayerInfo.reset()
#
#		if amount_meme == 0:
#			$Inventory/Meme.set_self_modulate(1,1,1,0.5)
#		else: 
#			$Inventory/Meme.set_self_modulate(1,1,1,1)
#		if amount_gun == 0:
#			$Inventory/Gun.set_self_modulate(1,1,1,0.5)
#		else: 
#			$Inventory/Gun.set_self_modulate(1,1,1,1)
#		if amount_sign == 0:
#			$Inventory/Sign.set_self_modulate(1,1,1,0.5)
#		else: 
#			$Inventory/Sign.set_self_modulate(1,1,1,1)
#		if amount_words == 0:
#			$Inventory/Words.set_self_modulate(1,1,1,0.5)
#		else: 
#			$Inventory/Words.set_self_modulate(1,1,1,1)
	#$ArmPosition/Arm/Sprite.position = $ArmPosition

func _physics_process(delta):
	get_input()
#	velocity = move_and_slide(velocity)
#	if velocity != Vector2.ZERO:
#		$Sprite.hide()
#		$Run_animation.show()
#		if $ArmPosition.is_flipped == true:
#			$AnimationPlayer.play("running_flipped")
#		else:
#			$AnimationPlayer.play("Running")
#	else:
#		$Run_animation.hide()
#		$Sprite.show()
#		if $ArmPosition.is_flipped == true:
#			$AnimationPlayer.play("Idle_flipped")
#		else:
#			$AnimationPlayer.play("Idle")

func shoot():
	if PlayerInfo.current_shots >= 1 and not Input.is_action_pressed("Reload"):
		var b = bullet.instance()
		owner.add_child(b)
		b.libdeal = libdeal
		b.repdeal = repdeal
		b.transform = $ArmPosition/Arm/CollisionShape2D/Position2D.global_transform
		PlayerInfo.change_shots(-1)
	if PlayerInfo.current_shots <= 1 and not Input.is_action_pressed("Reload"):
		state = "reload"

func charge_shoot():
	if PlayerInfo.current_charges >= 1:
		var c = chargeshot.instance()
		owner.add_child(c)
		c.transform = $ArmPosition/Arm/CollisionShape2D/Position2D.global_transform
		PlayerInfo.change_charge(-1)
		$Chargereload.start()
		
func _on_Reload_Time_timeout():
	if reload_time == 0.3:
		PlayerInfo.change_shots(+0.1)
	elif reload_time >= 1 or reload_time <= 2:
		PlayerInfo.change_shots(+0.2)
	elif reload_time >= 0.6 or reload_time <= 1.5:
		PlayerInfo.change_shots(+0.3)
	else:
		PlayerInfo.change_shots(+0.4)
		
	

func _on_ReloadTimer_timeout():
	if reload_time >= 0.5:
		reload_time += -0.05
		$ReloadTimer.wait_time = reload_time
	else:
		$ReloadTimer.wait_time = 0.05

func _ready():
	add_to_group("player")
	global_position = PlayerInfo.player_spawn_pos
	inventory_pos = 1
	amount_gun = PlayerInfo.get_guns()
	amount_words = PlayerInfo.get_words()
	amount_sign = PlayerInfo.get_signs()
	amount_meme = PlayerInfo.get_memes()
	


func _on_HitBox_area_entered(area):
	if area.is_in_group("projectiles"):
		if area.side == "Left":
			PlayerInfo.change_health(-1)
		else:
			PlayerInfo.change_health(+1)
		area.queue_free()
		
	if area.is_in_group("enemies"):
		if area.side == "Left":
			PlayerInfo.change_health(-1)
		else:
			PlayerInfo.change_health(+1)
		


func _on_Chargereload_timeout():
	PlayerInfo.change_charge(+1)
	$Chargereload.start()


func _on_Libtimer_timeout():
	libdeal = 1


func _on_Reptimer_timeout():
	repdeal = 1
