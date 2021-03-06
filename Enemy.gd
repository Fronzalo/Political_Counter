extends KinematicBody2D

var speed = 150
var velocity 
onready var player = get_node("/root/World/Player")
var powerdrop = preload("res://Powerup.tscn")
var move = true
var side
var s 
var drop = 0

var target = Vector2.ZERO
var health = 3


func _ready():
	add_to_group("enemies")
	s = round(rand_range(1,2))
	if s == 2:
		side = "Right"
		$Colour_Changer.play("Become Woke")
	else:
		side = "Left"
		$Colour_Changer.play("Become Based")




func _physics_process(delta):
#	velocity = position.direction_to(player.position) * speed
	velocity = target * speed
	if move : move_and_slide(velocity)
	
		
func get_side():
	return(side)


func _process(delta):
	if health <= 0:
		if side == "Left":
			PlayerInfo.liberal_killed(1)
		else:
			PlayerInfo.republican_killed(1)
		PlayerInfo.change_score(200)
		PlayerInfo.boss_counter(200)
		drop = floor(rand_range(1,6))
		if drop == 1:
			var d = powerdrop.instance()
			d.global_position = global_position
			get_parent().add_child(d)
		queue_free()

func _on_Go_timeout():
	move = true
	target = position.direction_to(player.position)
	$Pause.wait_time = rand_range(3,6)
	$Pause.start()

func _on_Pause_timeout():
	move = false
	$Go.wait_time = rand_range(3,6)
	$Go.start()


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		if side == "Left":
			PlayerInfo.change_health(-1)
		else:
			PlayerInfo.change_health(+1)

