extends Area2D

export var bullet_speed = 100



func _ready():
	add_to_group("projectiles")
	$AnimationPlayer.playback_speed = 2
	$AnimationPlayer.play("Fire")

var velocity = Vector2()

func _physics_process(delta):
	position += transform.x * bullet_speed * delta




func _on_projectile_body_entered(body):
	if body.is_in_group("enemies"):
		body.health -= 1
	queue_free()
	


func _on_projectile_area_entered(area):
	if area.is_in_group("enemies"):
		area.health -= 1
	queue_free()
