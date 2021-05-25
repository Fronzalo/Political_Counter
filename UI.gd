extends Control


func _ready():
	$Healthbar.max_value = PlayerInfo.health_max
	
func _process(delta):
	$Healthbar.value = PlayerInfo.get_health()
	$Reload.value = PlayerInfo.get_shots()
	$Score_Counter.text = "SCORE: " + str(PlayerInfo.get_score())
	$highscore_counter.text = "HIGHSCORE: " + str(PlayerInfo.get_high())
	if PlayerInfo.get_high() <= 0:
		$highscore_counter.hide()
	else:
		$highscore_counter.show()
	
