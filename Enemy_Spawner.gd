extends Position2D
var enemy = preload("res://Enemy.tscn")
var can_spawn = true
var y_spawn

func _process(delta):
	if can_spawn == true:
		y_spawn = round(rand_range(0,600))
		var e = enemy.instance()
		e.position.x = position.x
		e.position.y = y_spawn
		owner.add_child(e)
		
		
		can_spawn = false
		$Timer.start()
		
func _on_Timer_timeout():
	$Timer.wait_time = rand_range(10,25)
	can_spawn = true
	$Timer.start()
