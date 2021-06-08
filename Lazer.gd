extends Node2D

const MAX_Length = 2000
onready var beam = $Sprite
onready var end = $End
onready var raycast2d = $RayCast2D
var body
var enabled = false
	
func _physics_process(delta):
	$AnimationPlayer.play("lazer flash")
	$AnimationPlayer.playback_speed = 6
	if raycast2d.is_colliding():
		end.global_position = raycast2d.get_collision_point()

	else:
		end.global_position = raycast2d.cast_to
	beam.region_rect.end.x = end.position.length()*10


func _on_hitscan_timeout():
	body = $RayCast2D.get_collider()
	print(body)
	if body.name == "Player":
		PlayerInfo.change_health(+1)
		print(PlayerInfo.get_health())
