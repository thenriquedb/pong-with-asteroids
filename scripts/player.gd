extends CharacterBody2D

@export var SPEED = 500

var ball

func _ready():
	ball = get_parent().get_node("Ball")

func _physics_process(delta: float):
	self.velocity.x = 0

	if ball.started == false:
		return 
	
	if Input.is_action_pressed("ui_left"):
		self.velocity.x -= SPEED
	elif Input.is_action_pressed("ui_right"):
		self.velocity.x += SPEED
	
	move_and_collide(velocity * delta)
