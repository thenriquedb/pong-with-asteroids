extends Node2D

@onready var ball = $Ball
@onready var label_pongs = $LabelPongs
@onready var tutorial_label = $Tutorial
@onready var positions = $Positions

var last_postion 
var asteroid_scene = preload("res://scenes/asteroid.tscn")

func _process(delta):
	if Input.is_key_pressed(KEY_R):
		reload_scene()
	
	if ball.started:
		label_pongs.visible = true
		tutorial_label.visible = false
			
	label_pongs.text = str(ball.pongs)	

func _on_hole_body_entered(body: Node2D) -> void:
	call_deferred("reload_scene")
	
func reload_scene():
	get_tree().reload_current_scene()

# Spawn the asteroids
func _on_timer_spawner_timeout() -> void:
	spawn_asteroid()

func spawn_asteroid():
	if !ball.started: return
	
	var positions_list = positions.get_children()
	var spawn_position = positions_list.pick_random()
	
	if(spawn_position != last_postion):
		var asteroid_instance = asteroid_scene.instantiate()
		asteroid_instance.global_position = spawn_position.position
		add_child(asteroid_instance)
		last_postion = spawn_position
	else:
		spawn_asteroid()
		
