extends Area2D

#movement variables
var rotation_speed
var movement_direction
var movement_speed
var acceleration = 0
#combat variables
var hitpoints = 3
signal enemy_destroyed

func _ready():
	position = Vector2(225,100)
	self.add_to_group("Enemies")


func _process(delta):
	#rotate the enemy
	rotation_degrees += rotation_speed * delta
	
	#accelerate the enemy
	movement_speed += acceleration
	
	#move the enemy along trajectory
	position += movement_direction * delta * movement_speed
	
	#kill enemy when HP is 0
	if hitpoints <= 0:
		emit_signal("enemy_destroyed")
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
