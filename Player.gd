extends Area2D

#movement variables
var thrust = 500
var velocity = Vector2()
var max_velocity = 150
var acceleration = Vector2()
var friction = 2
var rotation_rate = PI/2
var screen_size

#combat variables
var hitpoints = 3
signal hitpoints_notification(hitpoints)

#laser variables
var ready_to_shoot = true
var shoot_timer
var shoot_interval = 0.2
onready var Laser = preload("res://Laser.tscn")

func _ready():
	screen_size = get_viewport_rect().size
	position.x = screen_size.x / 2
	position.y = screen_size.y / 1.25
	
	#prepare the laser timer
	shoot_timer = Timer.new()
	shoot_timer.wait_time = shoot_interval
	shoot_timer.connect("timeout", self, "_on_shoot_timer_timeout")
	add_child(shoot_timer)
	
	#display hitpoints
	emit_signal("hitpoints_notification", hitpoints)

func _process(delta):
	#keyboard input
	if Input.is_action_pressed("ui_right"):
		acceleration = Vector2(thrust,0)
	elif Input.is_action_pressed("ui_left"):
		acceleration = Vector2(-thrust,0)
	elif Input.is_action_pressed("ui_up"):
		acceleration = Vector2(0,-thrust)
	elif Input.is_action_pressed("ui_down"):
		acceleration = Vector2(0,thrust)
	else: acceleration = Vector2(0,0)
	#movement
	acceleration += velocity * -friction
	velocity += acceleration * delta
	position += velocity * delta
	#clamp player bounds of the screen
	position.x = clamp(position.x, 16, screen_size.x - 16) #12 is to offset size of the player
	position.y = clamp(position.y, 16, screen_size.y - 16) #12 is to offset size of the player
	
	#shoot lasers
	if Input.is_action_pressed("ui_select") and ready_to_shoot:
		var laser = Laser.instance()
		get_parent().add_child(laser)
		ready_to_shoot = false
		shoot_timer.start()

func _on_shoot_timer_timeout():
	ready_to_shoot = true


func _on_Player_area_entered(area):
	if area.is_in_group("Enemies"):
		hitpoints -= 1
		emit_signal("hitpoints_notification", hitpoints)
