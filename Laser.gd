extends Area2D

var laser_direction
var laser_speed = 500
var laser_velocity

func _ready():
	self.transform = get_parent().get_node("Player").transform
	laser_direction = rotation - PI/2
	laser_velocity = Vector2(laser_speed, 0).rotated(laser_direction)

func _process(delta):
	global_position += laser_velocity * delta
