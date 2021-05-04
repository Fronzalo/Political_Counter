extends KinematicBody2D
export (PackedScene) var Bullet
export var bullet_speed = 100

var velocity = Vector2()

func _physics_process(delta):
	position += transform.x * bullet_speed * delta


