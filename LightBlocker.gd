extends Area2D

var hitpoints = 300

func _process(delta):
	if hitpoints <= 0:
		queue_free()
