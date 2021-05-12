extends Node

var health
var health_max
var max_shots = 9
var current_shots = 9
var lives
var lives_max

func _ready():
	health = 5
	health_max = 9
	max_shots = 9
	current_shots = 9
	
func change_health(amount):
	health += amount
	health = clamp(health,0, health_max)
	
func change_shots(amount):
		current_shots += amount
		current_shots = clamp(current_shots,0, max_shots)

	
func get_health():
	return health

func get_shots():
	return current_shots

func reset():
	current_shots = 9
	health = 5
