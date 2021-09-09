extends Area2D
var amount_meme 
var amount_gun 
var amount_sign 
var amount_words 
#var size = get_viewport().get_visible_rect().size
var ypos

func _on_Scene_Changer_body_entered(body):
	if body.name == "Player":
		amount_meme = body.amount_meme 
		amount_gun = body.amount_gun
		amount_sign = body.amount_sign 
		amount_words = body.amount_words 
		ypos = body.position.y
		if body.position.x > 500:
			PlayerInfo.player_spawn_pos = Vector2(50, ypos)
		if body.position.x < 500:
			PlayerInfo.player_spawn_pos = Vector2(950, ypos)
		get_tree().reload_current_scene()
		body.amount_meme = amount_meme
		body.amount_gun = amount_gun
		body.amount_sign = amount_sign
		body.amount_words = amount_words
