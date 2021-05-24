extends HBoxContainer

enum MODES {simple, empty}

var charge_full = preload("res://boltcon.png")
var charge_empty = preload("res://boltcon_empty.png")

export (MODES) var mode = MODES.simple

func _process(delta):
	update_empty()


func update_empty():
	for i in get_child_count():
		if PlayerInfo.get_charges() > i:
			get_child(i).texture = charge_full
		else:
			get_child(i).texture = charge_empty
