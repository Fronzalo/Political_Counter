extends Node

#Pause screne# 

func _ready():
	pass # Replace with function body.


func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().paused = true
		$"Pause Screen".visible = true

