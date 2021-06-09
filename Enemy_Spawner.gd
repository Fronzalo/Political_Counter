extends Position2D
var enemy = preload("res://Enemy.tscn")
var shootingenemy = preload("res://Shootingenemy.tscn")
var trump = preload("res://Trump.tscn")
var can_spawn = true
var y_spawn
var what_spawn = enemy
onready var size = get_viewport().get_visible_rect().size
var left 
var bosstype

func _process(delta):
	if can_spawn == true:
		
		y_spawn = round(rand_range(0,300))
		var e = what_spawn.instance()
		if left == 1:
			e.position.x = global_position.x
		if left == 2:
			e.position.x = global_position.x + size.x - 100
		e.position.y = global_position.y + y_spawn
		owner.add_child(e)
		can_spawn = false
		$Timer.start()
	if PlayerInfo.bosspawn() >= 1000:
		bosstype = 1#round(rand_range(1,3))
		if bosstype == 1:
			trump()
		else:
			pass #biden()
		PlayerInfo.boss_counter(-1500)
			
	
func _on_Timer_timeout():
	$Timer.wait_time = rand_range(6,16)
	var r = rand_range(1,5)
	if r >= 1 and r <= 3:
		what_spawn = enemy
	else:
		what_spawn = shootingenemy
	print(what_spawn)
	can_spawn = true
	left = round(rand_range(1,3))
	print(left)
	$Timer.start()

func trump():
	print("TRUMP IS HERE!")
	left = round(rand_range(1,3))
	y_spawn = round(rand_range(0,300))
	var t = trump.instance()
	if left == 1:
		t.position.x = global_position.x
	if left == 2:
		t.position.x = global_position.x + size.x - 100
	t.position.y = global_position.y + y_spawn
	owner.add_child(t)
	can_spawn = false
