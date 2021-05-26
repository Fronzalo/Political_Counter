extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta):
	$pause_panel/CenterContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer/counter_box/Score_Counter.text = "SCORE: " + str(PlayerInfo.get_score())
	$pause_panel/CenterContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer/counter_box/highscore_counter.text = "HIGHSCORE: " + str(PlayerInfo.get_high())
	$pause_panel/CenterContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer/counter_box/libkil.text = "Liberals \n SILENCED: " + str(PlayerInfo.liberals_killed())
	$pause_panel/CenterContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer/counter_box/repkil.text = "Republicans \n STOPPED: " + str(PlayerInfo.republicans_killed())
	$pause_panel/CenterContainer/Panel/MarginContainer/VBoxContainer/Panel/healthbar.value = PlayerInfo.get_health()
	$pause_panel/CenterContainer/Panel/MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/VBoxContainer/MarginContainer2/Ammo1.value = PlayerInfo.get_shots()

func _on_continue_pressed():
		yield(get_tree(),"idle_frame")
		get_tree().paused = false
		visible = false



func _on_quit_pressed():
	get_tree().quit()


func _on_reset_pressed():
		get_tree().reload_current_scene()
		PlayerInfo.reset()
