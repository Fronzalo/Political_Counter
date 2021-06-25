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


func _on_Explosion_Area_body_entered(body):
	bullet_speed = 0
	$Sprite.hide()
	$explosion.show()
	$AnimationPlayer.play("explosion")
	yield($AnimationPlayer,"animation_finished")
	queue_free()



func _on_Explosion_body_entered(body):
	if body.is_in_group("enemies"):
		body.health -= 4




func _on_Explosion_Area_area_entered(area):
	print(area)
	if area.name != "Arm" and area.name != "Explosion":
		bullet_speed = 0
		$Sprite.hide()
		$explosion.show()
		$AnimationPlayer.play("explosion")
		yield($AnimationPlayer,"animation_finished")
		queue_free()

func _on_Explosion_area_entered(area):
	if area.is_in_group("enemies"):
		area.health -= 4


