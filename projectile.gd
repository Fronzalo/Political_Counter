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
		if body.name == "Enemy":
			if body.side == "Left":
				PlayerInfo.liberal_killed(1)
			else:
				PlayerInfo.republican_killed(1)
		PlayerInfo.change_score(200)
		if body.name == "Shooter":
			if body.side == "Left":
				PlayerInfo.liberal_killed(1)
			else:
				PlayerInfo.republican_killed(1)
			PlayerInfo.change_score(350)
		body.queue_free()
	queue_free()
	
