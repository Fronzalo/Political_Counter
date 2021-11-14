extends KinematicBody2D

var speed = 150
var velocity 
onready var player =get_node("/root/Player")
var move = true
var side
var movex = 0
var movey = 0
var shoot
var drop
var powerdrop = preload("res://Powerup.tscn")
var s 
onready var bullet = preload("res://Enemyprojectile.tscn")
var target = Vector2.ZERO
var health = 2


func _ready():
	add_to_group("enemies")
	s = round(rand_range(1,2))
	if s == 2:
		side = "Right"
		$Colour_Changer.play("Become Woke")
	else:
		side = "Left"
		$Colour_Changer.play("Become Based")


func _process(delta):
	if health <= 0:
		if side == "Left":
			PlayerInfo.liberal_killed(1)
		else:
			PlayerInfo.republican_killed(1)
		PlayerInfo.change_score(350)
		PlayerInfo.boss_counter(350)
		drop = floor(rand_range(1,6))
		if drop == 1:
			var d = powerdrop.instance()
			d.global_position = global_position
			get_parent().add_child(d)
		queue_free()
		
		
func _physics_process(delta):
	if move == true:
		target = Vector2(movex, movey).normalized()
		move_and_slide(target * speed)
	if shoot == true:
		shoot()
		
func shoot():
		var e = bullet.instance()
		get_parent().add_child(e)
		e.transform = $Gun/CollisionShape2D/Position2D.global_transform
		e.side = get_side()
		shoot = false 
		$Shoot.start()

func get_side():
	return side

func _on_Go_timeout():
#	print("go")
	move = true
	movex = rand_range(-20,20)
	movey = rand_range(-200,200)
	$Pause.wait_time = rand_range(3,6)
	$Pause.start()

func _on_Pause_timeout():
#	print("pause")
	move = false
	$Go.wait_time = rand_range(3,6)
	$Go.start()


func _on_Shoot_timeout():
	shoot = true
	$Shoot.wait_time = rand_range(1,5)
