extends Area2D

var laser_direction
var laser_speed = 300
var laser_velocity

func _ready():
	laser_direction = get_parent().rotation - PI/2

func _process(delta):
	laser_velocity = Vector2(laser_speed, 0).rotated(laser_direction)
	global_position += laser_velocity * delta
