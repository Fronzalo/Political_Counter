extends KinematicBody2D

var speed = 150
var velocity 
onready var player =get_node("/root/Player")
var move = true
var side
var movex = 0
var movey = 0
var shoot
var s 
onready var bullet = preload("res://Enemyprojectile.tscn")
var target = Vector2.ZERO

func _ready():
	add_to_group("enemies")
	s = round(rand_range(1,2))
	if s == 1:
		side = "Left"
	else:
		side = "Right"

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
	print("go")
	move = true
	movex = rand_range(-20,20)
	movey = rand_range(-200,200)
	$Pause.wait_time = rand_range(3,6)
	$Pause.start()

func _on_Pause_timeout():
	print("pause")
	move = false
	$Go.wait_time = rand_range(3,6)
	$Go.start()


func _on_Shoot_timeout():
	shoot = true
	$Shoot.wait_time = rand_range(1,5)