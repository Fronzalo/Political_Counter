extends KinematicBody2D

var speed = 150
var velocity 
onready var player = get_parent().get_node("Player")
var move = true

var target = Vector2.ZERO

func _ready():
	add_to_group("enemies")



func _physics_process(delta):
#	velocity = position.direction_to(player.position) * speed
	velocity = target * speed
	if move : move_and_slide(velocity)
		
	
		
func _process(delta):
	pass

func _on_Go_timeout():
	print("go")
	move = true
	target = position.direction_to(player.position)
	$Pause.wait_time = rand_range(3,6)
	$Pause.start()

func _on_Pause_timeout():
	print("pause")
	move = false
	$Go.wait_time = rand_range(3,6)
	$Go.start()
