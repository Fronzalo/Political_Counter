extends Node

var health
var health_max
var max_shots = 9
var current_shots = 9
var current_charges = 3
var max_charges
var libkill 
var repkill
var lives
var lives_max
var score
var highscore
var bosscount
var bossspawn = 1000
var player_spawn_pos = Vector2(500,300)
var memes = 0
var signs = 0
var guns = 0
var words = 0

func _ready():
	
	health = 9
	health_max = 18
	max_shots = 9
	max_charges = 3
	current_charges = 3
	current_shots = 9
	score = 0
	highscore = 0
	libkill = 0
	repkill = 0
	bosscount = 0

func boss_counter(amount):
	bosscount += amount
	bosscount = clamp(bosscount,0,bossspawn)

func bosspawn():
	return bosscount

func liberal_killed(amount):
	libkill += amount

func liberals_killed():
	return libkill

func republican_killed(amount):
	repkill += amount

func republicans_killed():
	return repkill


func change_health(amount):
	health += amount
	health = clamp(health,0, health_max)
	
func change_shots(amount):
		current_shots += amount
		current_shots = clamp(current_shots,0, max_shots)
		
func change_score(amount):
	score += amount

func change_charge(amount):
	current_charges += amount
	current_charges = clamp(current_charges,0, max_charges)

func change_memes(amount):
	memes += amount
func change_guns(amount):
	guns += amount
func change_words(amount):
	words += amount
func change_signs(amount):
	signs += amount


func get_charges():
	return current_charges

func get_memes():
	return memes
func get_signs():
	return signs
func get_guns():
	return guns
func get_words():
	return words

func get_health():
	return health

func get_shots():
	return current_shots

func get_score():
	return score

func get_high():
	return highscore

func reset():
	current_shots = 9
	health = 9
	libkill = 0
	repkill = 0
	if highscore <= score:
		highscore = score
	else:
		highscore = highscore
	memes = 0 
	signs = 0
	guns = 0
	words = 0

	score = 0
