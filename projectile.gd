extends Area2D

export var bullet_speed = 100
func _ready():
	add_to_group("projectiles")

var velocity = Vector2()

func _physics_process(delta):
	position += transform.x * bullet_speed * delta




func _on_projectile_body_entered(body):
	if body.is_in_group("enemies"):
		body.queue_free()
	queue_free()
	
