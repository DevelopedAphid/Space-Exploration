extends Node2D

var time_to_spawn_next_enemy = 2.5
var enemy_spawn_timer
var next_angle = 0
var number_per_pulse = 36
var angle_increment = 2 * PI / number_per_pulse
var enemy_movement_speed = 50
onready var Enemy = preload("res://Enemy.tscn")

func _ready():
	#prepare the enemy spawn timer
	enemy_spawn_timer = Timer.new()
	enemy_spawn_timer.wait_time = time_to_spawn_next_enemy
	enemy_spawn_timer.connect("timeout", self, "_on_enemy_spawn_timer_timeout")
	add_child(enemy_spawn_timer)
	enemy_spawn_timer.start()

func _on_enemy_spawn_timer_timeout():
	for _n in range(number_per_pulse):
		var enemy = Enemy.instance()
		
		#rotation speed
		enemy.rotation_speed = 180
		#movement trajectory
		enemy.movement_direction = Vector2(sin(next_angle), cos(next_angle))
		enemy.movement_speed = enemy_movement_speed
		enemy.acceleration = 0.5
		
		get_parent().add_child(enemy)
		
		next_angle += angle_increment
	
	enemy_spawn_timer.start()
