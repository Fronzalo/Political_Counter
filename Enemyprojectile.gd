extends Area2D

var side
export var bullet_speed = 100
func _ready():
	add_to_group("projectiles")

var velocity = Vector2()

func _physics_process(delta):
	position += transform.x * bullet_speed * delta








