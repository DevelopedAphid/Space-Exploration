extends Node2D

func _on_Player_hitpoints_notification(hitpoints):
	get_node("Hitpoint_Label").text = str(hitpoints)
