extends Area2D
var eshape = preload("res://explosionshape.tres")
export var bullet_speed = 100

onready var explosion = $Explosion
var radi = 0
func _ready():
	add_to_group("projectiles")
	$AnimationPlayer.playback_speed = 2
	$AnimationPlayer.play("fire")
	$explosion.hide()
	$Sprite.show()

var velocity = Vector2()

func _physics_process(delta):
	position += transform.x * bullet_speed * delta


func _on_Area2D_body_entered(body):
	bullet_speed = 0
	$Sprite.hide()
	$explosion.show()
	$AnimationPlayer.play("explosion")
	yield($AnimationPlayer,"animation_finished")
	queue_free()




func _on_Explosion_body_entered(body):
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
