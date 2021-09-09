extends Area2D

var powerup

func _ready():
	powerup = floor(rand_range(1,5))
	print(powerup)
	if powerup == 1:
		$Meme.show()
	elif powerup == 2:
		$Gun.show()
	elif powerup == 3:
		$Sign.show()
	elif powerup == 4:
		$Words.show()


func _on_Powerup_body_entered(body):
	if body.name == "Player":
		if powerup == 1:
			PlayerInfo.change_memes(+1)
		elif powerup == 2:
			PlayerInfo.change_guns(+1)
		elif powerup == 3:
			PlayerInfo.change_signs(+1)
		elif powerup == 4:
			PlayerInfo.change_words(+1)
	queue_free()
