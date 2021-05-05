extends KinematicBody2D

var speed = 150
var velocity 
onready var player = get_parent().get_node("Player")
var move = true



func _ready():
	add_to_group("enemies")



func _physics_process(delta):
#	velocity = position.direction_to(player.position) * speed
	if move == true:
		velocity = position.direction_to(player.position) * speed
		move_and_slide(velocity)
	else:
		pass



func _on_Go_timeout():
	if move == false:
		$Pause.start()

func _on_Pause_timeout():
	if move == true:
		$Go.start()
