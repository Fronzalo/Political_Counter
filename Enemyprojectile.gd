extends Area2D

var side
export var bullet_speed = 100
func _ready():
	add_to_group("projectiles")

var velocity = Vector2()

func _physics_process(delta):
	position += transform.x * bullet_speed * delta












func _on_Enemyprojectile_body_entered(body):
	if body.name == "Border":
		queue_free()
