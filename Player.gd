extends Area2D

var thrust = 500
var velocity = Vector2()
var max_velocity = 150
var acceleration = Vector2()
var friction = 2
var rotation_rate = PI/2
var screen_size


onready var Laser = preload("res://Laser.tscn")

func _ready():
	screen_size = get_viewport_rect().size
	position.x = screen_size.x / 2
	position.y = screen_size.y / 1.25

func _process(delta):
#	#free movement (explorer)
#	#rotation
#	if Input.is_action_pressed("ui_right"):
#		rotation += rotation_rate * delta
#	if Input.is_action_pressed("ui_left"):
#		rotation -= rotation_rate * delta
#	#acceleration
#	if Input.is_action_pressed("ui_up"):
#		acceleration = Vector2(thrust, 0).rotated(rotation-PI/2) # - PI/2 accounts for sprite pointing upward
#	else: 
#		acceleration = Vector2(0, 0)
#	acceleration += velocity * -friction
#	#velocity
#	velocity += acceleration * delta
#	position += velocity * delta
#
#	velocity = velocity.clamped(max_velocity)
#
	
	#restricted movement (vertical SHMUP)
	if Input.is_action_pressed("ui_right"):
		acceleration = Vector2(thrust,0)
	elif Input.is_action_pressed("ui_left"):
		acceleration = Vector2(-thrust,0)
	elif Input.is_action_pressed("ui_up"):
		acceleration = Vector2(0,-thrust)
	elif Input.is_action_pressed("ui_down"):
		acceleration = Vector2(0,thrust)
	else: acceleration = Vector2(0,0)
	
	acceleration += velocity * -friction
	velocity += acceleration * delta
	position += velocity * delta
	
	position.x = clamp(position.x, 16, screen_size.x - 16) #12 is to offset size of the player
	position.y = clamp(position.y, 16, screen_size.y - 16) #12 is to offset size of the player
	
	#shoot lasers
	if Input.is_action_pressed("ui_select"):
		var laser = Laser.instance()
		get_parent().add_child(laser)
