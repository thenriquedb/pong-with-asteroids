extends Area2D

@export var speed = 140
@export var rotation_speed = 1.3

@onready var animated_sprite = $AnimatedSprite2D  # Adicione esta linha

@onready var timer_delete = $TimerDelete

const SCREEN_WIDTH = 540
var start_side
 
func _ready() -> void:
	if(global_position.x > SCREEN_WIDTH):
		start_side = "right"
	else:
		start_side = "left"

func _process(delta: float) -> void:
	if(start_side == "right"):
		global_position.x -= speed * delta
		rotation -= rotation_speed * delta
	elif(start_side == "left"):
		global_position.x += speed * delta
		rotation += rotation_speed * delta
	
func _on_visible_notifer_screen_exited() -> void:
	timer_delete.start()

func _on_body_entered(body: Node2D) -> void:
	animated_sprite.play()
	body.pongs += 1
	
	if body.is_in_group("Ball"):
		body.velocity.y *= -1

func _on_finished_destroy_animation() -> void:
	queue_free()
