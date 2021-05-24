extends Position2D

export (int) var speed = 200

var velocity = Vector2()

var x_pos
onready var is_flipped = true


func get_input():

	var look_vec = get_global_mouse_position() - global_position
	global_rotation = atan2(look_vec.y, look_vec.x)
	#print(look_vec)
	if look_vec.x <= 0:
		get_parent().get_node("Sprite").flip_h=true
		get_parent().get_node("Run_animation").flip_h=true
		$Arm/Sprite.flip_v=true
		is_flipped = true
		
	else:
		get_parent().get_node("Sprite").flip_h=false
		get_parent().get_node("Run_animation").flip_h=false
		$Arm/Sprite.flip_v=false
		is_flipped = false

func _physics_process(delta):
	get_input()
		
		
		
		
