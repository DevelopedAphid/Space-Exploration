extends Area2D

var laser_direction
var laser_speed = 500
var laser_velocity
var laser_damage = 1

func _ready():
	add_to_group("Lasers")
	self.transform = get_parent().get_node("Player").transform
	global_position -= Vector2(0,24) #24 is to offset the position to the nose tip
	laser_direction = rotation - PI/2
	laser_velocity = Vector2(laser_speed, 0).rotated(laser_direction)
	
	#to do: laser cooldown timer so you can only shoot x per second

func _process(delta):
	global_position += laser_velocity * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Laser_area_entered(area):
	if area.name != "Player" and !area.is_in_group("Lasers"):
		queue_free()
		area.hitpoints -= laser_damage
