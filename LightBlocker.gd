extends Area2D

var hitpoints = 30

func _process(_delta):
	if hitpoints <= 0:
		queue_free()
