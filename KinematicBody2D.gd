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
	if PlayerInfo.get_health() <= 0:
		get_tree().reload_current_scene()
		PlayerInfo.reset()

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)

func shoot():
	var b = bullet.instance()
	owner.add_child(b)
	b.transform = $Arm/CollisionShape2D/Position2D.global_transform
	
