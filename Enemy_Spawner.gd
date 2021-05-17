extends Position2D
var enemy = preload("res://Enemy.tscn")
var shootingenemy = preload("res://Shootingenemy.tscn")
var can_spawn = true
var y_spawn
var what_spawn = enemy
func _process(delta):
	if can_spawn == true:
		y_spawn = round(rand_range(0,600))
		var e = what_spawn.instance()
		e.position.x = position.x
		e.position.y = y_spawn
		owner.add_child(e)
		
		
		can_spawn = false
		$Timer.start()
		
func _on_Timer_timeout():
	$Timer.wait_time = rand_range(10,25)
	var r = rand_range(1,5)
	print(r)
	if r >= 1 and r <= 3:
		what_spawn = enemy
	else:
		what_spawn = shootingenemy
		
	can_spawn = true
	$Timer.start()
