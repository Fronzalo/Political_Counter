extends Area2D
var target = Vector2.ZERO
var side
var xpos = 0
var ypos = 0
onready var size = 0
export var bullet_speed = 500
#onready var inital_look = $Position2D
var inital_look = Vector2(0, position.y-10)
#var screenSize = get_viewport().get_visible_rect().size
var fired = false
#var rndX = rng.randi_range(0, screenSize.x)
#var rndY = rng.randi_range(0, screenSize.y)
func _ready():
	side = "right"
	add_to_group("projectiles")
	size = get_viewport().get_visible_rect().size
	$Explosion.hide()
	$Rocket.show()
#	target = Vector2.UP

var velocity = Vector2()

func _physics_process(delta):
	if fired == true:
		position = position.move_toward(target,bullet_speed * delta)
		if position.x == target.x and position.y == target.y:
			bullet_speed = 0
			target = Vector2(position.x+1000, position.y)
			look_at(target)
			$Rocket.hide()
			$Explosion.show()
			$AnimationPlayer.play("explosion")
			yield($AnimationPlayer,"animation_finished")
			queue_free()
	else:
		translate(Vector2.UP * bullet_speed * delta)
		$AnimationPlayer.play("in the air")


func _on_VisibilityNotifier2D_screen_exited():
	print("##########################################################CHINA")
	$RocketFall.start()


func _on_RocketFall_timeout():
	print("TIME OUT########################################################")
	xpos = rand_range(0,size.x)
	ypos = rand_range(0,size.y) # Replace with function body.
	target = Vector2(xpos, ypos)
	print(target)
	look_at(target)
	fired = true
	
