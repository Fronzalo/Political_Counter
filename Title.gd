extends Node2D





func _on_Start_pressed():
	get_tree().change_scene("res://Testing grounds.tscn")


func _on_Quit_pressed():
	get_tree().quit()
