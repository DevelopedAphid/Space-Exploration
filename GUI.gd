extends Node2D

var score

func _ready():
	score = 0

func _process(delta):
	get_node("Score_Label").text = str(score)

func _on_Player_hitpoints_notification(hitpoints):
	get_node("Hitpoint_Label").text = str(hitpoints)
