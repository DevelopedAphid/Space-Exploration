extends Area2D

var thrust = 500
var velocity = Vector2()
var max_velocity = 150
var acceleration = Vector2()
var friction = 2
var rotation_rate = PI/2

func _ready():
	position = get_viewport_rect().size/2
	rotation = PI/2

func _process(delta):
	#rotation
	if Input.is_action_pressed("ui_right"):
		rotation += rotation_rate * delta
	if Input.is_action_pressed("ui_left"):
		rotation -= rotation_rate * delta
	#acceleration
	if Input.is_action_pressed("ui_up"):
		acceleration = Vector2(thrust, 0).rotated(rotation-PI/2) # - PI/2 accounts for sprite pointing upward
	else: 
		acceleration = Vector2(0, 0)
	acceleration += velocity * -friction
	#velocity
	velocity += acceleration * delta
	position += velocity * delta
	
	velocity = velocity.clamped(max_velocity)
	
