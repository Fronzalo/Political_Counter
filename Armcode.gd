extends Area2D

export (int) var speed = 200

var velocity = Vector2()
var pos_x = position.x
var neg_x = -position.x

func get_input():

	var look_vec = get_global_mouse_position() - global_position
	global_rotation = atan2(look_vec.y, look_vec.x)
	#print(look_vec)
	if look_vec.x <= 0:
		get_parent().get_node("Sprite").flip_h=true
		position.x = neg_x
		
	else:
		get_parent().get_node("Sprite").flip_h=false
		position.x = pos_x

func _physics_process(delta):
	get_input()


