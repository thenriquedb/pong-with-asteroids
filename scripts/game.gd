extends Node2D

@onready var ball = $Ball
@onready var label_pongs = $LabelPongs
@onready var tutorial_label = $Tutorial
@onready var background = $Background

var asteroid_scene = preload("res://scenes/asteroid.tscn")
var new_asteroid_color

var text: String

var resources = {}

func _ready():
	preload_resources()

func _process(delta):
	if Input.is_key_pressed(KEY_R):
		reload_scene()
	
	if ball.started:
		label_pongs.visible = true
		tutorial_label.visible = false
		check_pongs(ball.pongs)
			
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
	
	var random_y = randf_range(100, 700)

	var asteroid_instance = asteroid_scene.instantiate()
	asteroid_instance.global_position = Vector2(-50, random_y)
	
	add_child(asteroid_instance)

func preload_resources():
	resources = {
		"theme_1": {
			"asteroid": preload("res://sprites/Asteroide1.png"),
			"background": preload("res://sprites/Fundo1.png"),
			"color": "242424"
		},
		"theme_2": {
			"asteroid": preload("res://sprites/Asteroide2.png"),
			"background": preload("res://sprites/Fundo2.png"),
			"color": "4196ff"
		},
		"theme_3": {
			"asteroid": preload("res://sprites/Asteroide3.png"),
			"background": preload("res://sprites/Fundo3.png"),
			"color":"4ea771",
		},
		"theme_4": {
			"asteroid": preload("res://sprites/Asteroide4.png"),
			"background": preload("res://sprites/Fundo4.png"),
			"color":"fe9c35",
		},
		"theme_5": {
			"asteroid": preload("res://sprites/Asteroide5.png"),
			"background": preload("res://sprites/Fundo5.png"),
			"color":"ff5d5d",
		},
		"theme_6": {
			"asteroid": preload("res://sprites/Asteroide6.png"),
			"background": preload("res://sprites/Fundo6.png"),
			"color":"762d79",
		},
	}

func check_pongs(current_pongs: int):
	match current_pongs:
		0: update_theme("theme_1")
		10: update_theme("theme_2")
		20: update_theme("theme_3")
		30: update_theme("theme_4")
		40: update_theme("theme_5")
		50: update_theme("theme_6")

	
func update_theme(theme_key: String):
	label_pongs.label_settings.font_color = resources[theme_key].color
	background.set_texture(resources[theme_key].background)
	#update_asteroids(theme_key)
	
func update_asteroids(theme_key):
	var asteroids = get_tree().get_nodes_in_group("asteroids")
	
	for asteroid in asteroids:
		asteroid.get_node("Sprite2D").texture = resources[theme_key].asteroid
	
	new_asteroid_color = resources[theme_key].asteroid
	
