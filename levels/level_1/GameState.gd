extends Node

var player_score = 0
var player_life = 100

func add_score(score_to_add):
	player_score += score_to_add

func decrement_player_life(damage):
	player_life -= damage
	if player_life <= 0:
		get_tree().current_scene.find_child("Player").destroy()
