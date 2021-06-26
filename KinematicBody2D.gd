extends KinematicBody2D
export (int) var speed = 200
var velocity = Vector2()
onready var chargetimer = false
onready var m = 0
var reload_amount
var reload_time = 0.3
var bullet = preload("res://projectile.tscn")
var chargeshot = preload("res://chargeshot.tscn")

func get_input():
	velocity = Vector2()
	velocity.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	velocity.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	velocity = velocity.normalized() * speed

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
	
	if Input.is_action_just_pressed("Reload"):
		$ReloadTimer.wait_time = 0.6
		reload_amount = 0
		$ReloadTimer.start()
		$ReloadTimer/Reload_Time.start()
		
	
	if Input.is_action_just_released("Reload"):
		$ReloadTimer.stop()
		$ReloadTimer/Reload_Time.stop()
		reload_amount = 0
		$ReloadTimer.wait_time = 0.3
		
		
#	if Input.is_action_just_pressed("shoot"):
#			shoot()
#	if Input.is_action_just_pressed("alt_fire"):
#		charge_shoot()


func _on_chargetimer_timeout():
	chargetimer = true
	print("Charged!")


func _process(delta):
	if PlayerInfo.get_health() <= 0 or PlayerInfo.get_health() >= 9:
		get_tree().reload_current_scene()
		PlayerInfo.reset()

func _physics_process(delta):
	get_input()
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

func shoot():
	if PlayerInfo.current_shots >= 1 and not Input.is_action_pressed("Reload"):
		var b = bullet.instance()
		owner.add_child(b)
		b.transform = $ArmPosition/Arm/CollisionShape2D/Position2D.global_transform
		PlayerInfo.change_shots(-1)

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






