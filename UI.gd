extends Control


func _ready():
	$Healthbar.max_value = PlayerInfo.health_max
	
func _process(delta):
	$Healthbar.value = PlayerInfo.get_health()
	$Reload.value = PlayerInfo.get_shots()
	$Score_Counter.text = "SCORE: " + str(PlayerInfo.get_score())
