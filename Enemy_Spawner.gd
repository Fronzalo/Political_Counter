extends Position2D
var bullet = preload("res://projectile.tscn")
var can_spawn = true
var y_spawn

func _process(delta):
	if can_spawn == true:
		y_spawn = round(rand_range(0,600))
		var b = bullet.instance()
		owner.add_child(b)
		b.position.x = -50
		b.position.y = y_spawn
		can_spawn = false
		$Timer.start()
		
func _on_Timer_timeout():
	can_spawn = true
	$Timer.start()
