extends Node2D

var time_to_spawn_next_enemy = 0.1
var enemy_spawn_timer
var next_angle = 0
var angle_increment = 5
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
	var enemy = Enemy.instance()
	
	#rotation speed
	enemy.rotation_speed = 180
	#movement trajectory
	enemy.movement_direction = Vector2(sin(next_angle), cos(next_angle))
	enemy.movement_speed = enemy_movement_speed

	get_parent().add_child(enemy)
	
	enemy.connect("enemy_destroyed", self, "_on_Enemy_Destroyed")

	enemy_spawn_timer.start()
	next_angle += angle_increment

func _on_Enemy_Destroyed():
	get_parent().get_node("GUI").score += 1
	#to do: convert this to a signal!
