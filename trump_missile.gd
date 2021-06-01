extends Area2D
var target = Vector2.ZERO
var side
var xpos = 0
var ypos = 0
onready var size = 0
export var bullet_speed = 100
func _ready():
	side = "right"
	add_to_group("projectiles")
	size = get_viewport().get_visible_rect().size
	randomize()

var velocity = Vector2()

func _physics_process(delta):
	#translate(Vector2.UP * bullet_speed * delta)
	position -= transform.y * bullet_speed * delta
	#position += transform.y * bullet_speed * delta
	#print(position, rotation_degrees)
	
	





func _on_VisibilityNotifier2D_screen_exited():
	print("##########################################################CHINA")
	$RocketFall.start()


func _on_RocketFall_timeout():
	print("TIME OUT########################################################")
	xpos = 0#rand_range(0,size.x)
	ypos = 0#rand_range(0,size.y) # Replace with function body.
	target = Vector2(xpos, ypos)
	print(target)
	look_at(target)
	
