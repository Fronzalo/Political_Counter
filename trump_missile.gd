extends Area2D
var target = Vector2.ZERO
var side
onready var size = 0
export var bullet_speed = 100
func _ready():
	side = "right"
	add_to_group("projectiles")
	size = get_viewport().get_visible_rect().size

var velocity = Vector2()

func _physics_process(delta):
	position += transform.x * bullet_speed * delta
	


func _on_quoteunquote_gravity_timeout():
	target = Vector2(rand_range(0,size.x), rand_range(0,size.y))
	var look_vec = target.position - global_position
	global_rotation = atan2(look_vec.y, look_vec.x)
