extends Node2D

var score

func _ready():
	score = 0

func _on_Player_hitpoints_notification(hitpoints):
	get_node("Hitpoint_Label").text = str(hitpoints)

func _on_SpiralEnemySpawner_add_to_score():
	_add_to_score()

func _on_CirclePulseEnemySpawner_add_to_score():
	_add_to_score()

func _add_to_score():
	score += 1
	get_node("Score_Label").text = str(score)
