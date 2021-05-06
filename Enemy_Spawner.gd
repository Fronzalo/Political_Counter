extends Position2D
var enemy = preload("res://Enemy.tscn")
var can_spawn = true
var y_spawn

func _process(delta):
	if can_spawn == true:
		y_spawn = round(rand_range(0,600))
		var e = enemy.instance()
		owner.add_child(e)
		e.position.x = -50
		e.position.y = y_spawn
		can_spawn = false
		$Timer.start()
		
func _on_Timer_timeout():
	$Timer.wait_time = rand_range(10,25)
	can_spawn = true
	$Timer.start()
