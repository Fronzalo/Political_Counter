extends Node2D
onready var Player = $DeadPlayer
var DeathText
onready var speed = 200
onready var start = PlayerInfo.player_spawn_pos

func _ready():
	$DeadPlayer.position.x = PlayerInfo.player_spawn_pos.x
	$DeadPlayer.position.y = PlayerInfo.player_spawn_pos.y



func _process(delta):
 
	$DeadPlayer.position = $DeadPlayer.position.move_toward(Vector2(512,300),speed * delta)
	
func _physics_process(delta):
	
	if Player.global_position.x != 512 and Player.global_position.y != 300: #((512, 300)
		pass
	else:
		DeathText = PlayerInfo.death_get()
		
		if DeathText == 1:
			$DeadPlayer/AnimationPlayer.play("Death")
			$Text_Animation.play("WOKE")
			$Button_animation.play("button stuff")
			PlayerInfo.get_death(9)
		if DeathText == 2:
			$DeadPlayer/AnimationPlayer.play("Death")
			$Text_Animation.play("BASED")
			$Button_animation.play("button stuff")
			PlayerInfo.get_death(9)
	
	if PlayerInfo.get_high() <= 0:
		$highscore_counter.hide()
	else:
		$highscore_counter.show()
	$Score_Counter.text = "SCORE: " + str(PlayerInfo.get_score()+0)
	$highscore_counter.text = "HIGHSCORE: " + str(PlayerInfo.get_high())
	if PlayerInfo.get_high() <= 0:
		$highscore_counter.hide()
	else:
		$highscore_counter.show()


func _on_Retry_pressed():
	PlayerInfo.change_health(-100)
	PlayerInfo.change_health(+9)
	get_tree().change_scene("res://Testing grounds.tscn")

func _on_Quit_pressed():
	get_tree().quit()
