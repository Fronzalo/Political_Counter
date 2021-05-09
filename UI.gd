extends Control


func _ready():
	$Healthbar.max_value = PlayerInfo.health_max
	
func _process(delta):
	$Healthbar.value = PlayerInfo.get_health()
