extends CharacterBody2D

var started = false
var incrmental_speed = 1.03
var angle = [-250, 250]
var pongs = 0

@export var START_SPEED = 500

func _physics_process(delta: float):	
	if Input.is_action_pressed("Start") and started == false:
		start_game()
		
	if !started: return
	
	var collision = move_and_collide(velocity * delta)
	if !collision: return
	
	if collision.get_collider().name == "TopWall":
		velocity = velocity.bounce(collision.get_normal()) * incrmental_speed
		pongs += 1
	else:
		velocity = velocity.bounce(collision.get_normal())

func start_game():
	started = true
	velocity.y = -START_SPEED
	velocity.x = angle.pick_random()
	
