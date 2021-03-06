extends Area2D

onready var player = get_node("/root/World/Player")
export (int) var speed = 200

var velocity = Vector2()
var pos_x = position.x
var neg_x = -position.x

#The gun turns to point at the player#

func get_input():
	var look_vec = player.position - global_position
	global_rotation = atan2(look_vec.y, look_vec.x)
	#print(look_vec)
	if look_vec.x <= 0:
		get_parent().get_node("Sprite").flip_h=true
		$Sprite.flip_v = true
		position.x = neg_x
		
	else:
		get_parent().get_node("Sprite").flip_h=false
		position.x = pos_x
		$Sprite.flip_v = false

func _physics_process(delta):
	get_input()
