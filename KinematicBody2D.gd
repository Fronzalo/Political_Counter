extends KinematicBody2D
export (int) var speed = 200
var velocity = Vector2()
var bullet = preload("res://projectile.tscn")
func get_input():
	velocity = Vector2()
	velocity.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	velocity.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	velocity = velocity.normalized() * speed
	
	if Input.is_action_just_pressed("shoot"):
			shoot()

func _process(delta):
	if PlayerInfo.get_health() <= 0 or PlayerInfo.get_health() >= 9:
		get_tree().reload_current_scene()
		PlayerInfo.reset()

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)

func shoot():
	if PlayerInfo.current_shots >= 1:
		var b = bullet.instance()
		owner.add_child(b)
		b.transform = $Arm/CollisionShape2D/Position2D.global_transform
		PlayerInfo.change_shots(-1)
		$ReloadTimer.start()


func _on_ReloadTimer_timeout():
		PlayerInfo.change_shots(+0.1)

func _ready():
	add_to_group("player")
	$Arm/CollisionShape2D.disabled = true


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
		
