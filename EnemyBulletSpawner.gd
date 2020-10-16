extends Node2D

var time_to_spawn_next_enemy = 2
var enemy_spawn_timer
var enemy_movement_speed = 100
onready var New_Enemy = preload("res://Enemy_Bullet.tscn")

func _ready():
	#prepare the enemy spawn timer
	enemy_spawn_timer = Timer.new()
	enemy_spawn_timer.wait_time = time_to_spawn_next_enemy
	enemy_spawn_timer.connect("timeout", self, "_on_enemy_spawn_timer_timeout")
	add_child(enemy_spawn_timer)
	enemy_spawn_timer.start()

func _on_enemy_spawn_timer_timeout():
	var new_enemy = New_Enemy.instance()
	
	#movement trajectory
	new_enemy.movement_direction = Vector2(0,1)
	new_enemy.movement_speed = enemy_movement_speed
	new_enemy.acceleration = 0.5
	new_enemy.position = get_parent().position
		
	get_parent().get_parent().add_child(new_enemy)
	
	enemy_spawn_timer.start()
