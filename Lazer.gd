extends Node2D

const MAX_Length = 2000
onready var beam = $Sprite
onready var end = $End
onready var raycast2d = $RayCast2D

func _physics_process(delta):
	$AnimationPlayer.play("lazer flash")
	$AnimationPlayer.playback_speed = 6
	if raycast2d.is_colliding():
		end.global_position = raycast2d.get_collision_point()
	else:
		end.global_position = raycast2d.cast_to * 10
	beam.region_rect.end.x = end.position.length()
