extends Node

var health
var health_max
var ammo_max
var ammo
var lives
var lives_max

func _ready():
	health = 5
	health_max = 9
	
func change_health(amount):
	health += amount
	health = clamp(health,0, health_max)
	

	
func get_health():
	return health

func reset():
	health = 5
